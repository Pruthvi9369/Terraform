resource "azurerm_subnet_route_table_association" "route_table_association" {
  route_table_id = "${var.route_table_association_id}"
  subnet_id = "${var.route_table_association_subnet_id}"
}
