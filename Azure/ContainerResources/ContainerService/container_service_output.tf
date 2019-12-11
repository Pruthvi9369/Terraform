output "container_service_id" {
  description = "Container service Id"
  value = azurerm_container_registry.container_service.id
}

output "container_service_login_server" {
  description = "Container service login server"
  value = azurerm_container_registry.container_service.login_server
}

output "container_service_admin_username" {
  description = "Container service admin username"
  value = azurerm_container_registry.container_service.admin_username
}

output "container_service_admin_password" {
  description = "Container service admin password"
  value = azurerm_container_registry.container_service.admin_password
}
