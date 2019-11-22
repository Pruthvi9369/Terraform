output "network_security_group_id" {
  description = "Network Security Group Id"
  value = azurerm_network_security_group.network_security_group.id
}

output "network_security_group_name" {
  description = "Network Security Group Name"
  value = azurerm_network_security_group.network_security_group.name
}
