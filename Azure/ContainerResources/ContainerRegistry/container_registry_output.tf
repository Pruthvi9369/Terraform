output "container_registry_id" {
  description = "Container Registry Id"
  value = azurerm_container_registry.container_registry.id
}

output "container_registry_login_server" {
  description = "Container Registry login server"
  value = azurerm_container_registry.container_registry.login_server
}

output "container_registry_admin_username" {
  description = "Container Registry admin username"
  value = azurerm_container_registry.container_registry.admin_username
}

output "container_registry_admin_password" {
  description = "Container Registry admin password"
  value = azurerm_container_registry.container_registry.admin_password
}
