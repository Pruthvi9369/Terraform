output "network_interface_id" {
  description = "network interface id"
  value = azurerm_network_interface.network_interface.id
}

output "network_interface_mac_address" {
  description = "network interface mac_address"
  value = azurerm_network_interface.network_interface.mac_address
}

output "network_interface_private_ip_address" {
  description = "network interface private_ip_address"
  value = azurerm_network_interface.network_interface.private_ip_address
}

output "network_interface_private_ip_addresses" {
  description = "network interface private_ip_addresses"
  value = azurerm_network_interface.network_interface.private_ip_addresses
}

output "network_interface_virtual_machine_id" {
  description = "network interface virtual_machine_id"
  value = azurerm_network_interface.network_interface.virtual_machine_id
}

output "network_interface_applied_dns_servers" {
  description = "network interface applied_dns_servers"
  value = azurerm_network_interface.network_interface.applied_dns_servers
}
