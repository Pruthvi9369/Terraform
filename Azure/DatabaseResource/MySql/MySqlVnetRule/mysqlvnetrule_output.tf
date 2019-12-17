output "mysqlventrule_id" {
  description = "MySql server virtual network id"
  value = azurerm_mysql_virtual_network_rule.mysqlventrule.id
}
