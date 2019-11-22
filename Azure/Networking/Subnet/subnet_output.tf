output "subnet_id" {
  description = "subnet id"
  value = azurerm_subnet.subnet.id
}

output "subnet_ip_configurations" {
  description = "subnet ip configuration"
  value = azurerm_subnet.subnet.ip_configurations
}

output "subnet_name" {
  description = "subnet name"
  value = azurerm_subnet.subnet.name
}

output "subnet_resource_group_name" {
  description = "subnet resource group name"
  value = azurerm_subnet.subnet.resource_group_name
}

output "subnet_virtual_network_name" {
  description = "subnet viratual network name"
  value = azurerm_subnet.subnet.virtual_network_name
}

output "subnet_address_prefix" {
  description = "subnet address prefix"
  value = azurerm_subnet.subnet.address_prefix
}
