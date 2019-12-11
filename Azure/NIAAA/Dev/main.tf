provider "azurerm" {

}

module "Vnet-dev01-eastUS-01" {
  source = "../../Networking/Virtual_Network/"
  resource_group_name = "rg-ppp-dev-01"
  resource_group_location = "East US"
  virtual_network_name = "Vnet-dev01-eastUS-01"
  virtual_network_address_space = ["172.12.0.0/8"]
}

module "snet-public-dev-app-01" {
  source = "../../Networking/Subnet/"
  subnet_name = "snet-public-dev-app-01"
  subnet_resource_group_name = "${module.Vnet-dev01-eastUS-01.virtual_network_resource_group_name}"
  subnet_virtual_network_name = "${module.Vnet-dev01-eastUS-01.virtual_network_name}"
  subnet_address_prefix = "172.12.2.0/24"
}

module "snet-private-dev-app-01" {
  source = "../../Networking/Subnet/"
  subnet_name = "snet-private-dev-app-01"
  subnet_resource_group_name = "${module.Vnet-dev01-eastUS-01.virtual_network_resource_group_name}"
  subnet_virtual_network_name = "${module.Vnet-dev01-eastUS-01.virtual_network_name}"
  subnet_address_prefix = "172.12.1.0/24"
}

module "public-routetable-dev-app-01" {
  source = "../../Networking/RouteTable/"
  route_table_name = "public-routetable-dev-app-01"
  route_table_location = "${module.Vnet-dev01-eastUS-01.virtual_network_location}"
  route_table_resource_group_name = "${module.Vnet-dev01-eastUS-01.virtual_network_resource_group_name}"
  route_table_route = [
    {
      name = "dev-app-internet-access"
      address_prefix = "0.0.0.0/0"
      next_hop_type = "Internet"
    }
  ]
}

module "Nsg-pps-weballow-01" {
  source = "../../Networking/Network_Security_group/"
  network_security_group_name = "Nsg-pps-weballow-01"
  network_security_group_resource_group_name = "${module.Vnet-dev01-eastUS-01.virtual_network_resource_group_name}"
  network_security_group_location = "${module.Vnet-dev01-eastUS-01.virtual_network_location}"
}

module "Ngs-pps-weballow-inbound-rule-01" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "Ngs-pps-weballow-inbound-rule-01"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.Vnet-dev01-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.Nsg-pps-weballow-01.network_security_group_name}"
  network_security_rule_description = "PPS Inbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "22"
  network_security_rule_destination_port_range = "22"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Inbound"
  network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "Ngs-pps-weballow-outbound-rule-01" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "Ngs-pps-weballow-outbound-rule-01"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.Vnet-dev01-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.Nsg-pps-weballow-01.network_security_group_name}"
  network_security_rule_description = "PPS Outbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "22"
  network_security_rule_destination_port_range = "22"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Outbound"
  network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  subnet_id = "${module.snet-public-dev-app-01.subnet_id}"
  route_table_id = "${module.public-routetable-dev-app-01.route_table_id}"
}

resource "azurerm_subnet_network_security_group_association" "network_securityd_group_association" {
  subnet_id = "${module.snet-public-dev-app-01.subnet_id}"
  network_security_group_id = "${module.Nsg-pps-weballow-01.network_security_group_id}"
}

module "vmpps001-public-ip" {
  source = "../../Networking/Public_Ipaddress/"
  public_ip_name = "vmpps001-public-ip"
  public_ip_resource_group_name = "${module.Vnet-dev01-eastUS-01.virtual_network_resource_group_name}"
  public_ip_location = "${module.Vnet-dev01-eastUS-01.virtual_network_location}"
}

module "vmpps001-networkinterface" {
  source = "../../Networking/Network_Interface/"
  network_interface_name = "vmpps001-networkinterface"
  network_interface_resource_group_name = "${module.Vnet-dev01-eastUS-01.virtual_network_resource_group_name}"
  network_interface_location = "${module.Vnet-dev01-eastUS-01.virtual_network_location}"
  network_interface_ip_configuration = [
    {
      name = "ss-networkinterface-ip-config"
      subnet_id = "${module.snet-public-dev-app-01.subnet_id}"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = "${module.vmpps001-public-ip.public_ip_id}"
    }
  ]
}

module "vmpps001" {
  source = "../../ComputeResources/VirtualMachine/"
  virtual_machine_name = "vmpps001"
  virtual_machine_resource_group_name = "${module.Vnet-dev01-eastUS-01.virtual_network_resource_group_name}"
  virtual_machine_location = "${module.Vnet-dev01-eastUS-01.virtual_network_location}"
  virtual_machine_network_interface_ids = ["${module.vmpps001-networkinterface.network_interface_id}"]
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
      name = "vmpps001-disk"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
  ]
  virtual_machine_os_profile = [
    {
      computer_name = "vmpps001"
      admin_username = "vmpps001User"
      admin_password = "Password1234!"
    }
  ]
  virtual_machine_os_profile_linux_config = [
    {
      disable_password_authentication = "false"
    }
  ]
}
