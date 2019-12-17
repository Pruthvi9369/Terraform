provider "azurerm" {

}

# rg-npps-prod-01 -The resource group contains the infrastructure components for production environment of NPPS application hosting listed in this documentation.
# The virtual network secures the NPPS application production environment resources.
module "vnet-web-niaaa-eastUS-01" {
  source = "../../Networking/Virtual_Network/"
  resource_group_name = "rg-npps-prod-01"
  resource_group_location = "East US"
  virtual_network_name = "vnet-web-niaaa-eastUS-01"
  virtual_network_address_space = ["186.0.0.0/8"]
}

# The subnet to host the npps application and API docker container
module "snet-npps-01" {
  source = "../../Networking/Subnet/"
  subnet_name = "snet-npps-01"
  subnet_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  subnet_virtual_network_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_name}"
  subnet_address_prefix = "186.0.2.0/24"
}

module "snet-npps-db-01" {
  source = "../../Networking/Subnet/"
  subnet_name = "snet-npps-db-01"
  subnet_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  subnet_virtual_network_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_name}"
  subnet_address_prefix = "186.0.1.0/24"
  subnet_service_endpoints = ["Microsoft.Sql"]
  subnet_delegation = [
    {
      name = "database_access"
        service_delegation = {
          name = "Microsoft.Sql/servers"
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
                      "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
        }
    }
  ]
}

# The route table to route network traffic from internet to npps application
module "routetable-npps-01" {
  source = "../../Networking/RouteTable/"
  route_table_name = "routetable-npps-01"
  route_table_location = "${module.vnet-web-niaaa-eastUS-01.virtual_network_location}"
  route_table_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  route_table_route = [
    {
      name = "npps-internet-access"
      address_prefix = "0.0.0.0/0"
      next_hop_type = "Internet"
    }
  ]
}

module "routetable-npps-db-01" {
  source = "../../Networking/RouteTable/"
  route_table_name = "routetable-npps-db-01"
  route_table_location = "${module.vnet-web-niaaa-eastUS-01.virtual_network_location}"
  route_table_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  route_table_route = [
    {
      name = "npps-db-routetable"
      address_prefix = "186.0.2.0/24"
      next_hop_type = "VirtualAppliance"
      next_hop_in_ip_address = "186.0.2.4"
    }
  ]
}

# The security group to define inbound and outbound rules for production virtual network. See rules modules below.
module "nsg-npps-allow-01" {
  source = "../../Networking/Network_Security_group/"
  network_security_group_name = "nsg-npps-allow-01"
  network_security_group_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_group_location = "${module.vnet-web-niaaa-eastUS-01.virtual_network_location}"
}

# The inbound rules associated with the NSG.
module "ngs-npps-allow-inbound-rule-01" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "ngs-npps-allow-inbound-rule-01"
  network_security_rule_protocol = "TCP"
  network_security_rule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-npps-allow-01.network_security_group_name}"
  network_security_rule_description = "PPS Inbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "22"
  network_security_rule_destination_port_range = "22"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28, 50.210.142.96/28"
}

# The inbound rules associated with the NSG.
module "ngs-npps-allow-inbound-rule-02" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "ngs-npps-allow-inbound-rule-02"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-npps-allow-01.network_security_group_name}"
  network_security_rule_description = "PPS Inbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "443"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "2000"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28, 50.210.142.96/28"
}

# The inbound rules associated with the NSG.
module "ngs-npps-allow-inbound-rule-03" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "ngs-npps-allow-inbound-rule-03"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-npps-allow-01.network_security_group_name}"
  network_security_rule_description = "PPS Inbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "80"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "3000"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28, 50.210.142.96/28"
}

# The inbound rules associated with the NSG.
module "ngs-npps-allow-inbound-rule-04" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "ngs-npps-allow-inbound-rule-04"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-npps-allow-01.network_security_group_name}"
  network_security_rule_description = "PPS Inbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "8000"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "4000"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28, 50.210.142.96/28"
}

# The inbound rules associated with the NSG.
module "ngs-npps-allow-inbound-rule-05" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "ngs-npps-allow-inbound-rule-05"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-npps-allow-01.network_security_group_name}"
  network_security_rule_description = "PPS Inbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "43554"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "500"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28, 50.210.142.96/28"
}

# The inbound rules associated with the NSG.
module "ngs-npps-allow-inbound-rule-06" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "ngs-npps-allow-inbound-rule-06"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-npps-allow-01.network_security_group_name}"
  network_security_rule_description = "PPS Inbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "3306"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "600"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28, 50.210.142.96/28"
}

# The outbound rules associated with the NSG.
module "ngs-npps-allow-outbound-rule-01" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "ngs-npps-allow-outbound-rule-01"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-npps-allow-01.network_security_group_name}"
  network_security_rule_description = "PPS Outbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "*"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Outbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

module "nsg-npps-db-allow-01" {
  source = "../../Networking/Network_Security_group/"
  network_security_group_name = "nsg-npps-db-allow-01"
  network_security_group_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_group_location = "${module.vnet-web-niaaa-eastUS-01.virtual_network_location}"
}

module "ngs-npps-db-allow-inbound-rule-01" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "ngs-npps-db-allow-inbound-rule-01"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-npps-db-allow-01.network_security_group_name}"
  network_security_rule_description = "NPPS db Inbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "*"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Inbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28, 50.210.142.96/28"
}

module "ngs-npps-db-allow-outbound-rule-01" {
  source = "../../Networking/Network_Security_Rule/"
  network_security_rule_name = "ngs-npps-db-allow-outbound-rule-01"
  network_security_rule_protocol = "*"
  network_security_rule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_security_rule_network_security_group_name = "${module.nsg-npps-db-allow-01.network_security_group_name}"
  network_security_rule_description = "NPPS db Outbound Rule for Netowrk security group"
  network_security_rule_source_port_range = "*"
  network_security_rule_destination_port_range = "*"
  network_security_rule_access = "Allow"
  network_security_rule_priority = "1000"
  network_security_rule_direction = "Outbound"
  #network_security_rule_destination_address_prefix = "209.183.243.112/28"
}

# Association of route table to application to subnet
resource "azurerm_subnet_route_table_association" "routetable-npps-01-association" {
  subnet_id = "${module.snet-npps-01.subnet_id}"
  route_table_id = "${module.routetable-npps-01.route_table_id}"
}

# Association of application subnet to NSG
resource "azurerm_subnet_network_security_group_association" "nsg-npps-allow-01-association" {
  subnet_id = "${module.snet-npps-01.subnet_id}"
  network_security_group_id = "${module.nsg-npps-allow-01.network_security_group_id}"
}


resource "azurerm_subnet_route_table_association" "routetable-npps-db-01-association" {
  subnet_id = "${module.snet-npps-db-01.subnet_id}"
  route_table_id = "${module.routetable-npps-db-01.route_table_id}"
}


resource "azurerm_subnet_network_security_group_association" "nsg-npps-db-allow-01-association" {
  subnet_id = "${module.snet-npps-db-01.subnet_id}"
  network_security_group_id = "${module.nsg-npps-db-allow-01.network_security_group_id}"
}

# The IP addresses for the resources
module "vm-npps-web-public-ip-01" {
  source = "../../Networking/Public_Ipaddress/"
  public_ip_name = "vm-npps-web-public-ip-01"
  public_ip_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  public_ip_location = "${module.vnet-web-niaaa-eastUS-01.virtual_network_location}"
}

#The NIC associated to the VM
module "vm-npps-web-networkinterface-01" {
  source = "../../Networking/Network_Interface/"
  network_interface_name = "vm-npps-web-networkinterface-01"
  network_interface_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  network_interface_location = "${module.vnet-web-niaaa-eastUS-01.virtual_network_location}"
  network_interface_ip_configuration = [
    {
      name = "vm-npps-web-networkinterface-ip-config"
      subnet_id = "${module.snet-npps-01.subnet_id}"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = "${module.vm-npps-web-public-ip-01.public_ip_id}"
    }
  ]
}

# The virtual machine that hosts the docker containers for npps application and UI
module "vm-npps-web-01" {
  source = "../../ComputeResources/VirtualMachine/"
  virtual_machine_name = "vm-npps-web-01"
  virtual_machine_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  virtual_machine_location = "${module.vnet-web-niaaa-eastUS-01.virtual_network_location}"
  virtual_machine_network_interface_ids = ["${module.vm-npps-web-networkinterface-01.network_interface_id}"]
  virtual_machine_vm_size = "Standard_DS2_v2"
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
      name = "vm-npps-web-disk"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
  ]
  virtual_machine_os_profile = [
    {
      computer_name = "vmnppsweb01"
      admin_username = "nppsadmin01"
      admin_password = "nI@@@theu$er1219!"
    }
  ]
  virtual_machine_os_profile_linux_config = [
    {
      disable_password_authentication = "false"
    }
  ]
}

# Azure database for MySQL managed instance for application backend.
module "db-npps-mysql-01" {
  source = "../../DatabaseResource/MySql/MySqlServer/"
  mysql_server_name = "db-npps-mysql-01"
  mysql_server_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  mysql_server_location = "${module.vnet-web-niaaa-eastUS-01.virtual_network_location}"
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
  mysql_server_administrator_login = "nppsmysqldb"
  mysql_server_administrator_login_password = "H@Sh1CoR3!"
  mysql_server_version = "5.7"
  mysql_server_ssl_enforcement = "Disabled"
}

/*
module "db-npps-mysql-01_snet_association" {
  source = "../../DatabaseResource/MySql/MySqlVnetRule"
  mysqlventrule_name = "db-npps-mysql-01_snet_association"
  mysqlventrule_resource_group_name = "${module.vnet-web-niaaa-eastUS-01.virtual_network_resource_group_name}"
  mysqlventrule_server_name = "${module.db-npps-mysql-01.mysql_server_id}"
  mysqlventrule_subnet_id = "${module.snet-npps-db-01.subnet_id}"

}
*/
