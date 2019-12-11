provider "azurerm" {

}

module "jenkins_VNet" {
  source = "../Networking/Virtual_Network/"
  resource_group_name = "jenkins_node"
  resource_group_location = "East US"
  virtual_network_name = "jenkins_vnet"
  virtual_network_address_space = ["10.0.0.0/8"]
}

module "jenkins_vnet_subnet" {
  source = "../Networking/Subnet/"
  subnet_name = "jenkins_subnet"
  subnet_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  subnet_virtual_network_name = "${module.jenkins_VNet.virtual_network_name}"
  subnet_address_prefix = "10.0.1.0/24"

}

module "jenkins_security_group" {
  source = "../Networking/Network_Security_group/"
  network_security_group_name = "jenkins_vnet_security_group"
  network_security_group_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_group_location = "${module.jenkins_VNet.virtual_network_location}"
}

module "jenkins_security_grou_inbound_rules" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_inbound_rule"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "*"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_group_outbound_rules" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_outbound_rule"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_outbound_rule"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "*"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Outbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

/*
module "jenkins_security_grou_outbound_rules_2" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_outbound_rules_2"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_outbound_rule_2"
  network_security_rule_source_port_range = "443"
  network_security_rule_destination_port_range = "443"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "300"
  network_security_rule_direction = "Outbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_grou_outbound_rules_3" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_outbound_rules_3"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_outbound_rule_3"
  network_security_rule_source_port_range = "8000"
  network_security_rule_destination_port_range = "8000"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "400"
  network_security_rule_direction = "Outbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_grou_outbound_rules_4" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_outbound_rules_4"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_outbound_rule_4"
  network_security_rule_source_port_range = "43554"
  network_security_rule_destination_port_range = "43554"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "500"
  network_security_rule_direction = "Outbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_group_inbound_rules_1" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_inbound_rules_1"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule_1"
  network_security_rule_source_port_range = "80"
  network_security_rule_destination_port_range = "80"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "200"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_grou_inbound_rules_2" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_inbound_rules_2"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule_2"
  network_security_rule_source_port_range = "443"
  network_security_rule_destination_port_range = "443"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "300"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_grou_inbound_rules_3" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_inbound_rules_3"
  network_security_rule_protocol = "Any"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule_3"
  network_security_rule_source_port_range = "8000"
  network_security_rule_destination_port_range = "8000"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "400"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_grou_inbound_rules_4" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_inbound_rules_4"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule_4"
  network_security_rule_source_port_range = "43554"
  network_security_rule_destination_port_range = "43554"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "500"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}
*/
/*
module "jenkins_security_grou_outbond_rules" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_outbound_rule"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_outbound_rule"
  network_security_rule_source_port_range = "22"
  network_security_rule_destination_port_range = "22"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "100"
  network_security_rule_direction = "Outbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}
*/

module "jenkins_vnet_public_ip" {
  source = "../Networking/Public_Ipaddress/"
  public_ip_name = "jenkins_public_ip"
  public_ip_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  public_ip_location = "${module.jenkins_VNet.virtual_network_location}"
}

resource "azurerm_subnet_network_security_group_association" "network_securityd_group_association" {
  subnet_id = "${module.jenkins_vnet_subnet.subnet_id}"
  network_security_group_id = "${module.jenkins_security_group.network_security_group_id}"
}

module "jenkins_vnet_network_interface" {
  source = "../Networking/Network_Interface/"
  network_interface_name = "jenkins_network_interface"
  network_interface_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_interface_location = "${module.jenkins_VNet.virtual_network_location}"
  #network_interface_internal_dns_name_label = "none"
  #network_interface_enable_accelerated_networking = "true"
  network_interface_network_security_group_id = "${module.jenkins_security_group.network_security_group_id}"
  network_interface_ip_configuration = [
    {
      name = "jenkins_network_interface_ip_configuration"
      subnet_id = "${module.jenkins_vnet_subnet.subnet_id}"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = "${module.jenkins_vnet_public_ip.public_ip_id}"
    }
  ]
}

module "jenkins_vm" {
  source = "../ComputeResources/VirtualMachine/"
  virtual_machine_name = "jenkins_machine"
  virtual_machine_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  virtual_machine_location = "${module.jenkins_VNet.virtual_network_location}"
  virtual_machine_network_interface_ids = ["${module.jenkins_vnet_network_interface.network_interface_id}"]
  virtual_machine_vm_size = "Standard_DS1_v2"
  virtual_machine_storage_image_reference = [
    {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "18.04-LTS"
      version = "latest"
    }
  ]
  virtual_machine_storage_os_disk = [
    {
      name = "JenkinsDisk"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
  ]
  virtual_machine_os_profile = [
    {
      computer_name = "jenkins"
      admin_username = "jenkinsUser"
      admin_password = "Password1234!"
    }
  ]
  virtual_machine_os_profile_linux_config = [
    {
      disable_password_authentication = "false"
    }
  ]

}

module "jenkins_vnet_public_ip_terraform" {
  source = "../Networking/Public_Ipaddress/"
  public_ip_name = "terraform_public_ip"
  public_ip_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  public_ip_location = "${module.jenkins_VNet.virtual_network_location}"
}

module "jenkins_vnet_network_interface_terraform" {
  source = "../Networking/Network_Interface/"
  network_interface_name = "terraform_network_interface"
  network_interface_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_interface_location = "${module.jenkins_VNet.virtual_network_location}"
  #network_interface_internal_dns_name_label = "none"
  #network_interface_enable_accelerated_networking = "true"
  network_interface_network_security_group_id = "${module.jenkins_security_group.network_security_group_id}"
  network_interface_ip_configuration = [
    {
      name = "terraform_network_interface_ip_configuration"
      subnet_id = "${module.jenkins_vnet_subnet.subnet_id}"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = "${module.jenkins_vnet_public_ip_terraform.public_ip_id}"
    }
  ]
}

module "terraform_vm" {
  source = "../ComputeResources/VirtualMachine/"
  virtual_machine_name = "Terraform_VM"
  virtual_machine_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  virtual_machine_location = "${module.jenkins_VNet.virtual_network_location}"
  virtual_machine_network_interface_ids = ["${module.jenkins_vnet_network_interface_terraform.network_interface_id}"]
  virtual_machine_vm_size = "Standard_DS1_v2"
  virtual_machine_storage_image_reference = [
    {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "18.04-LTS"
      version = "latest"
    }
  ]
  virtual_machine_storage_os_disk = [
    {
      name = "TerraformDisk"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
  ]
  virtual_machine_os_profile = [
    {
      computer_name = "terraform"
      admin_username = "TerraformUser"
      admin_password = "Password1234!"
    }
  ]
  virtual_machine_os_profile_linux_config = [
    {
      disable_password_authentication = "false"
    }
  ]

}

module "jenkins_contaier" {
  source = "../ContainerResources/ContainerRegistry/"
  container_registry_name = "NIAAARegistry"
  container_registry_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  container_registry_location = "${module.jenkins_VNet.virtual_network_location}"
  container_registry_sku = "Premium"
  container_registry_admin_enabled = true
  container_registry_georeplication_locations = ["East US 2"]

}
