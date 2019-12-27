provider "azurerm" {
  tenant_id = "bc9c5322-e3bf-4e14-8549-3dc2cf2037e8"
  subscription_id = "b7ecc78c-d7fe-4f1b-8c97-6816f5bf16b0"
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

module "jenkins_vnet_private_subnet" {
  source = "../Networking/Subnet/"
  subnet_name = "jenkins_private_subnet"
  subnet_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  subnet_virtual_network_name = "${module.jenkins_VNet.virtual_network_name}"
  subnet_address_prefix = "10.0.2.0/24"
  subnet_service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
  subnet_delegation = [
    {
      name = "database_access"
        service_delegation = {
          name = "Microsoft.Sql/managedInstances"
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
                      "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
        }
    }
  ]

}

module "jenkins_route_table" {
  source = "../Networking/RouteTable"
  route_table_name = "jenkins_route_table"
  route_table_location = "${module.jenkins_VNet.virtual_network_location}"
  route_table_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  route_table_route = [
    {
      name = "jenkins_route_table_route"
      address_prefix = "0.0.0.0/0"
      next_hop_type = "Internet"
    }
  ]
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  subnet_id = "${module.jenkins_vnet_subnet.subnet_id}"
  route_table_id = "${module.jenkins_route_table.route_table_id}"
  #depends_on = ["azurerm_subnet.jenkins_vnet_subnet"]
}

module "jenkins_route_table_private" {
  source = "../Networking/RouteTable"
  route_table_name = "jenkins_route_table_private"
  route_table_location = "${module.jenkins_VNet.virtual_network_location}"
  route_table_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  route_table_route = [
    {
      name = "jenkins_route_table_private_route"
      address_prefix = "10.0.1.0/24"
      next_hop_type = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.1.4"
    }
  ]
}

resource "azurerm_subnet_route_table_association" "route_table_private_association" {
  subnet_id = "${module.jenkins_vnet_private_subnet.subnet_id}"
  route_table_id = "${module.jenkins_route_table_private.route_table_id}"
  #depends_on = [jenkins_vnet_private_subnet.subnet_id]
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
  network_security_rule_priority = "100"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_group_inbound_rules_1" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_inbound_rule_1"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule_1"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "443"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "200"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}


module "jenkins_security_grou_inbound_rules_3" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_grou_inbound_rules_3"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule_3"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "80"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "300"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_grou_inbound_rules_4" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_grou_inbound_rules_4"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule_4"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "8000"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "400"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_grou_inbound_rules_5" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_grou_inbound_rules_5"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule_5"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "43554"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "500"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_grou_inbound_rules_6" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_grou_inbound_rules_6"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_inbound_rule_5"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "3306"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "600"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_security_grou_outbond_rules" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_security_group_outbound_rule"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_outbound_rule"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "*"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "100"
  network_security_rule_direction = "Outbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

resource "azurerm_subnet_network_security_group_association" "network_securityd_group_association" {
  subnet_id = "${module.jenkins_vnet_subnet.subnet_id}"
  network_security_group_id = "${module.jenkins_security_group.network_security_group_id}"
  #depends_on = [jenkins_vnet_subnet.subnet_id]
}



module "jenkins_private_security_group" {
  source = "../Networking/Network_Security_group/"
  network_security_group_name = "jenkins_private_security_group"
  network_security_group_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_group_location = "${module.jenkins_VNet.virtual_network_location}"
}

module "jenkins_private_security_group_inbound_rules" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_private_security_group_inbound_rules"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_private_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_private_inbound_rule"
  network_security_rule_source_port_range = "3306"
  network_security_rule_destination_port_range = "3306"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "100"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "jenkins_private_security_group_outbond_rules" {
  source = "../Networking/Network_Security_Rule/"
  network_security_rule_name = "jenkins_private_security_group_outbond_rules"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.jenkins_private_security_group.network_security_group_name}"
  network_security_rule_description = "jenkins_private_outbound_rule"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "*"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "100"
  network_security_rule_direction = "Outbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

resource "azurerm_subnet_network_security_group_association" "private_network_securityd_group_association" {
  subnet_id = "${module.jenkins_vnet_private_subnet.subnet_id}"
  network_security_group_id = "${module.jenkins_private_security_group.network_security_group_id}"
  #depends_on = [jenkins_vnet_private_subnet.subnet_id]
}

module "jenkins_vnet_public_ip" {
  source = "../Networking/Public_Ipaddress/"
  public_ip_name = "jenkins_public_ip"
  public_ip_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  public_ip_location = "${module.jenkins_VNet.virtual_network_location}"
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

/*
module "jenkinsdb" {
  source = "../DatabaseResource/MySql/MySqlServer"
  mysql_server_name = "jenkinsdb"
  mysql_server_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  mysql_server_location = "${module.jenkins_VNet.virtual_network_location}"
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
  mysql_server_administrator_login = "mysqladmin"
  mysql_server_administrator_login_password = "H@Sh1CoR3!"
  mysql_server_version = "5.7"
  mysql_server_ssl_enforcement = "Disabled"
}


module "jenkin_database_subnet_association" {
  source = "../DatabaseResource/MySql/MySqlVnetRule"
  mysqlventrule_name = "jenkin-database-subnet-association"
  mysqlventrule_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  mysqlventrule_server_name = "${module.jenkinsdb.mysql_server_id}"
  mysqlventrule_subnet_id = "${module.jenkins_vnet_private_subnet.subnet_id}"

}
*/

module "jenkins_storage_blob" {
  source = "../StorageResources/StorageAccount"
  storage_account_name = "axlejenkinsstorage"
  storage_account_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
  storage_account_location = "${module.jenkins_VNet.virtual_network_location}"
  storage_account_account_tier = "Standard"
  storage_account_account_replication_type = "LRS"
  storage_account_network_rules = [
    {
      default_action = "Deny"
      virtual_network_subnet_ids = ["${module.jenkins_vnet_private_subnet.subnet_id}"]
    }
  ]
}


module "jenkins_key_vault" {
  source = "../KeyVaultResources/KeyVault"
  key_vault_name = "axlejenkinskeyvault"
  key_vault_sku_name = "standard"
  key_vault_tenant_id = "bc9c5322-e3bf-4e14-8549-3dc2cf2037e8"
  key_vault_location = "${module.jenkins_VNet.virtual_network_location}"
  key_vault_resource_group_name = "${module.jenkins_VNet.virtual_network_resource_group_name}"
}
