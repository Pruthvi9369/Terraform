output "network_profile_id" {
  description = "Newtork Profile id"
  value = azurerm_network_profile.network_profile.id
}

output "network_profile_container_network_interface_ids" {
  description = "Newtork Profile id"
  value = azurerm_network_profile.network_profile.container_network_interface_ids
}
