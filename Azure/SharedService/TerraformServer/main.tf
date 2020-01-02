provider "azurerm" {

}

module "vnet-dev-01" {
  source = "../../Networking/Virtual_Network/"
  resource_group_name = "rg-ss-dev-01"
  resource_group_location = "East US"
  virtual_network_name = "vnet-dev-01"
  virtual_network_address_space = ["172.0.0.0/8"]
}

module "snet-ss-dev-01" {
  source = "../../Networking/Subnet/"
  subnet_name = "snet-ss-dev-01"
  subnet_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  subnet_virtual_network_name = "${module.vnet-dev-01.virtual_network_name}"
  subnet_address_prefix = "172.1.0.0/16"
  subnet_service_endpoints = ["Microsoft.Storage"]
}

module "rt-ss-01" {
  source = "../../Networking/RouteTable/"
  route_table_name = "rt-ss-01"
  route_table_location = "${module.vnet-dev-01.virtual_network_location}"
  route_table_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  route_table_route = [
    {
      name = "InternetAccess"
      address_prefix = "0.0.0.0/0"
      next_hop_type = "Internet"
    }
  ]
}

module "nsg-ss-01-allow-01" {
  source = "../../Networking/Network_Security_group/"
  network_security_group_name = "nsg-ss-01-allow-01"
  network_security_group_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  network_security_group_location = "${module.vnet-dev-01.virtual_network_location}"
}

module "Ngs-ss-weballow-inbound-rule" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "Ngs-ss-weballow-inbond-rule"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-ss-01-allow-01.network_security_group_name}"
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
  network_security_rule_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-ss-01-allow-01.network_security_group_name}"
  network_security_rule_description = "Shared Service Outbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "22"
  network_security_rule_destination_port_range = "22"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Outbound"
  network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  subnet_id = "${module.snet-ss-dev-01.subnet_id}"
  route_table_id = "${module.rt-ss-01.route_table_id}"
}

resource "azurerm_subnet_network_security_group_association" "network_securityd_group_association" {
  subnet_id = "${module.snet-ss-dev-01.subnet_id}"
  network_security_group_id = "${module.nsg-ss-01-allow-01.network_security_group_id}"
}

module "public-ip-ss-01" {
  source = "../../Networking/Public_Ipaddress/"
  public_ip_name = "public-ip-ss-01"
  public_ip_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  public_ip_location = "${module.vnet-dev-01.virtual_network_location}"

}

module "nw-interface-ss-01" {
  source = "../../Networking/Network_Interface/"
  network_interface_name = "nw-interface-ss-01"
  network_interface_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  network_interface_location = "${module.vnet-dev-01.virtual_network_location}"
  network_interface_ip_configuration = [
    {
      name = "ss-networkinterface-ip-config"
      subnet_id = "${module.snet-ss-dev-01.subnet_id}"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = "${module.public-ip-ss-01.public_ip_id}"
    }
  ]
}

module "vm-tf-01" {
  source = "../../ComputeResources/VirtualMachine/"
  virtual_machine_name = "vm-tf-01"
  virtual_machine_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  virtual_machine_location = "${module.vnet-dev-01.virtual_network_location}"
  virtual_machine_network_interface_ids = ["${module.nw-interface-ss-01.network_interface_id}"]
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
      name = "disk-vm-tf-01"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
  ]
  virtual_machine_os_profile = [
    {
      computer_name = "SsTerraform"
      admin_username = "SsTerraformUser"
      admin_password = "Password1234!"
    }
  ]
  virtual_machine_os_profile_linux_config = [
    {
      disable_password_authentication = "false"
    }
  ]
}

module "NIAAADockContainer" {
  source = "../../ContainerResources/ContainerRegistry/"
  container_registry_name = "NIAAADockContainer"
  container_registry_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  container_registry_location = "${module.vnet-dev-01.virtual_network_location}"
  container_registry_sku = "Premium"
  container_registry_admin_enabled = true
  container_registry_georeplication_locations = ["EastUS2"]

}

/*
module "storssdev01" {
  source = "../../StorageResources/StorageAccount"
  storage_account_name = "storssdev01"
  storage_account_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
  storage_account_location = "${module.vnet-dev-01.virtual_network_location}"
  storage_account_account_tier = "Standard"
  storage_account_account_replication_type = "LRS"
  storage_account_access_tier = "Hot"
  storage_account_network_rules = [
    {
      default_action = "Deny"
      virtual_network_subnet_ids = ["${module.snet-ss-dev-01.subnet_id}"]
    }
  ]
}
*/

module "kv-ss-01" {
  source = "../../KeyVaultResources/KeyVault/"
  key_vault_name = "kv-ss-01"
  key_vault_sku_name = "standard"
  key_vault_tenant_id = "bc9c5322-e3bf-4e14-8549-3dc2cf2037e8"
  key_vault_location = "${module.vnet-dev-01.virtual_network_location}"
  key_vault_resource_group_name = "${module.vnet-dev-01.virtual_network_resource_group_name}"
}
