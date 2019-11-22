output "virtual_network_id" {
  description = "virtual network Id"
  value = azurerm_virtual_network.virtual_network.id
}

output "virtual_network_name" {
  description = "virtual network Name"
  value = azurerm_virtual_network.virtual_network.name
}

output "virtual_network_resource_group_name" {
  description = "virtual network's resource group name"
  value = azurerm_virtual_network.virtual_network.resource_group_name
}

output "virtual_network_location" {
  description = "virtual network's location"
  value = azurerm_virtual_network.virtual_network.location
}

output "virtual_network_address_space" {
  description = "virtual network's address_space"
  value = azurerm_virtual_network.virtual_network.address_space
}

output "virtual_network_subnet" {
  description = "virtual network's subnet"
  value = azurerm_virtual_network.virtual_network.subnet
}
