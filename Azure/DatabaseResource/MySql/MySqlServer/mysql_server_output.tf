output "mysql_server_id" {
  description = "Mysql servier Id"
  value = azurerm_mysql_server.mysql_server.id
}

output "mysql_server_fqdn" {
  description = "Mysql servier fqdn"
  value = azurerm_mysql_server.mysql_server.fqdn
}
