provider "azurerm" {
  #subscription_id = ""
}

module "virtual_network" {
  source = "../../Networking/Virtual_Network/"
  resource_group_name = "niaaa_dev"
  resource_group_location = "East US"
  virtual_network_name = "Niaaa_virtual_network"
  virtual_network_address_space = ["172.16.0.0/16"]
}


module "virtual_network_routetable" {
  source = "../../Networking/RouteTable/"
  route_table_name = "niaaa_virtual_network_routetable"
  route_table_location = "${module.virtual_network.virtual_network_location}"
  route_table_resource_group_name = "${module.virtual_network.virtual_network_resource_group_name}"
  route_table_route = [
    {
      name = "route1"
      address_prefix = "0.0.0.0/0"
      next_hop_type = "Internet"
    }
  ]
}

module "virtual_network_security_group" {
  source = "../../Networking/Network_Security_group/"
  network_security_group_name = "niaaa_virtual_network_security_group"
  network_security_group_resource_group_name = "${module.virtual_network.virtual_network_resource_group_name}"
  network_security_group_location = "${module.virtual_network.virtual_network_location}"
}

module "virtual_network_security_group_rule" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "niaaa_network_security_group_rule"
  network_security_rule_resource_group_name = "${module.virtual_network.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.virtual_network_security_group.network_security_group_name}"
  network_security_rule_description = "niaaa_network_security_group_rule"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "100"
  network_security_rule_direction = "Outbound"
}

module "virtual_network_subnet" {
  source = "../../Networking/Subnet/"
  subnet_name = "niaaa_dev_subnet"
  subnet_resource_group_name = "${module.virtual_network.virtual_network_resource_group_name}"
  subnet_virtual_network_name = "${module.virtual_network.virtual_network_name}"
  subnet_address_prefix = "172.16.1.0/24"
  #subnet_network_security_group_id = "${module.virtual_network_security_group.network_security_group_id}"
  #subnet_route_table_id = "${module.virtual_network_routetable.route_table_id}"
}

#module "virtual_network_route_table_association" {
#  soruce = "../../Networking/RouteTableAssociation/"
#  route_table_association_id = "${module.virtual_network_routetable.route_table_id}"
#  route_table_association_subnet_id = "${module.virtual_network_subnet.subnet_id}"
#}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  subnet_id = "${module.virtual_network_subnet.subnet_id}"
  route_table_id = "${module.virtual_network_routetable.route_table_id}"
}

resource "azurerm_subnet_network_security_group_association" "network_securityd_group_association" {
  subnet_id = "${module.virtual_network_subnet.subnet_id}"
  network_security_group_id = "${module.virtual_network_security_group.network_security_group_id}"
}

module "virtual_network_public_ip" {
  source = "../../Networking/Public_Ipaddress/"
  public_ip_name = "niaaa_public_ip"
  public_ip_resource_group_name = "${module.virtual_network.virtual_network_resource_group_name}"
  public_ip_location = "${module.virtual_network.virtual_network_location}"

}

module "virtual_network_database" {
  source = "../../DatabaseResource/MySql/"
  mysql_server_name = "niaaa-mysql-server"
  mysql_server_resource_group_name = "${module.virtual_network.virtual_network_resource_group_name}"
  mysql_server_location = "${module.virtual_network.virtual_network_location}"
  mysql_server_sku = [
    {
      name = "B_Gen5_2"
      capacity = "2"
      tier = "Basic"
      family = "Gen5"
    }
  ]
  mysql_server_storage_profile = [
    {
      storage_mb = "5120"
      backup_retention_days = "7"
      geo_redundant_backup = "Disabled"
    }
  ]
  mysql_server_administrator_login = "mysqladminun"
  mysql_server_administrator_login_password = "H@Sh1CoR3!"
  mysql_server_version = "5.7"
  mysql_server_ssl_enforcement = "Disabled"
}

module "virtual_network_interface" {
  source = "../../Networking/Network_Interface/"
  network_interface_name = "niaaa_network_interface_name"
  network_interface_resource_group_name = "${module.virtual_network.virtual_network_resource_group_name}"
  network_interface_location = "${module.virtual_network.virtual_network_location}"
  network_interface_ip_configuration = [
    {
      name = "niaaa_network_interface_ip_configure_name"
      subnet_id = "${module.virtual_network_subnet.subnet_id}"
      private_ip_address_allocation = "Dynamic"
    }
  ]
}

module "virtual_network_virtual_machine" {
  source = "../../ComputeResources/VirtualMachine/"
  virtual_machine_name = "niaaa_vm"
  virtual_machine_resource_group_name = "${module.virtual_network.virtual_network_resource_group_name}"
  virtual_machine_location = "${module.virtual_network.virtual_network_location}"
  virtual_machine_network_interface_ids = ["${module.virtual_network_interface.network_interface_id}"]
  virtual_machine_vm_size = "Standard_DS1_v2"
  virtual_machine_storage_image_reference = [
    {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "16.04-LTS"
      version = "latest"
    }
  ]
  virtual_machine_storage_os_disk = [
    {
      name = "VMosdisk1"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
  ]
  virtual_machine_os_profile = [
    {
      computer_name = "hostname"
      admin_username = "testadmin"
      admin_password = "Password1234!"
    }
  ]
  virtual_machine_os_profile_linux_config = [
    {
      disable_password_authentication = "false"
    }
  ]
}
