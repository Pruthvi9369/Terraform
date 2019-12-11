provider "azurerm" {

}

module "Vnet-ss-eastUS" {
  source = "../../Networking/Virtual_Network/"
  resource_group_name = "rg-ss"
  resource_group_location = "East US"
  virtual_network_name = "Vnet-ss-eastUS"
  virtual_network_address_space = ["172.0.0.0/8"]
}

module "snet-ss" {
  source = "../../Networking/Subnet/"
  subnet_name = "snet-ss"
  subnet_resource_group_name = "${module.Vnet-ss-eastUS.virtual_network_resource_group_name}"
  subnet_virtual_network_name = "${module.Vnet-ss-eastUS.virtual_network_name}"
  subnet_address_prefix = "172.1.0.0/16"
}

module "ss-route-table" {
  source = "../../Networking/RouteTable/"
  route_table_name = "ss-route-table"
  route_table_location = "${module.Vnet-ss-eastUS.virtual_network_location}"
  route_table_resource_group_name = "${module.Vnet-ss-eastUS.virtual_network_resource_group_name}"
  route_table_route = [
    {
      name = "InternetAccess"
      address_prefix = "0.0.0.0/0"
      next_hop_type = "Internet"
    }
  ]
}

module "Ngs-ss-weballow" {
  source = "../../Networking/Network_Security_group/"
  network_security_group_name = "Ngs-ss-weballow"
  network_security_group_resource_group_name = "${module.Vnet-ss-eastUS.virtual_network_resource_group_name}"
  network_security_group_location = "${module.Vnet-ss-eastUS.virtual_network_location}"
}

module "Ngs-ss-weballow-inbound-rule" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "Ngs-ss-weballow-inbond-rule"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.Vnet-ss-eastUS.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.Ngs-ss-weballow.network_security_group_name}"
  network_security_rule_description = "Shared Service Inbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "22"
  network_security_rule_destination_port_range = "22"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Inbound"
  network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "Ngs-ss-weballow-outbound-rule" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "Ngs-ss-weballow-outbond-rule"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.Vnet-ss-eastUS.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.Ngs-ss-weballow.network_security_group_name}"
  network_security_rule_description = "Shared Service Outbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "22"
  network_security_rule_destination_port_range = "22"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Outbound"
  network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  subnet_id = "${module.snet-ss.subnet_id}"
  route_table_id = "${module.ss-route-table.route_table_id}"
}

resource "azurerm_subnet_network_security_group_association" "network_securityd_group_association" {
  subnet_id = "${module.snet-ss.subnet_id}"
  network_security_group_id = "${module.Ngs-ss-weballow.network_security_group_id}"
}

module "ss-public-ip" {
  source = "../../Networking/Public_Ipaddress/"
  public_ip_name = "ss-public-ip"
  public_ip_resource_group_name = "${module.Vnet-ss-eastUS.virtual_network_resource_group_name}"
  public_ip_location = "${module.Vnet-ss-eastUS.virtual_network_location}"

}

module "ss-networkinterface" {
  source = "../../Networking/Network_Interface/"
  network_interface_name = "ss-networkinterface"
  network_interface_resource_group_name = "${module.Vnet-ss-eastUS.virtual_network_resource_group_name}"
  network_interface_location = "${module.Vnet-ss-eastUS.virtual_network_location}"
  network_interface_ip_configuration = [
    {
      name = "ss-networkinterface-ip-config"
      subnet_id = "${module.snet-ss.subnet_id}"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = "${module.ss-public-ip.public_ip_id}"
    }
  ]
}

module "vmss" {
  source = "../../ComputeResources/VirtualMachine/"
  virtual_machine_name = "vmss"
  virtual_machine_resource_group_name = "${module.Vnet-ss-eastUS.virtual_network_resource_group_name}"
  virtual_machine_location = "${module.Vnet-ss-eastUS.virtual_network_location}"
  virtual_machine_network_interface_ids = ["${module.ss-networkinterface.network_interface_id}"]
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
      name = "vmss-disk"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
  ]
  virtual_machine_os_profile = [
    {
      computer_name = "vmss"
      admin_username = "VmssUser"
      admin_password = "Password1234!"
    }
  ]
  virtual_machine_os_profile_linux_config = [
    {
      disable_password_authentication = "false"
    }
  ]
}
