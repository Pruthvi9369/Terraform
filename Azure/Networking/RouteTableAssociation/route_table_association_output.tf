output "route_table_association_id" {
  description = "Please find the route table association id"
  value = azurerm_subnet_route_table_association.route_table_association.id
}
