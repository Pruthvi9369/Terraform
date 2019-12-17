resource "azurerm_mysql_virtual_network_rule" "mysqlventrule" {
  name = "${var.mysqlventrule_name}"
  resource_group_name = "${var.mysqlventrule_resource_group_name}"
  server_name = "${var.mysqlventrule_server_name}"
  subnet_id = "${var.mysqlventrule_subnet_id}"
}
