output "container_group_id" {
  description = "container group id"
  value = azurerm_container_group.container_group.id
}

output "container_group_ip_address" {
  description = "container group ip address"
  value = azurerm_container_group.container_group.ip_address
}

output "container_group_fqdn" {
  description = "container group fqdn"
  value = azurerm_container_group.container_group.fqdn
}
