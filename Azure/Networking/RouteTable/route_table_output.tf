output "route_table_id" {
  description = "Route table's Id"
  value = azurerm_route_table.route_table.id
}

output "route_table_subnet" {
  description = "Route table's Subnet"
  value = azurerm_route_table.route_table.subnets
}
