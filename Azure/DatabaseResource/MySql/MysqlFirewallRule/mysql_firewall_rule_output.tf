output "mysql_firewall_rule_id" {
  description = "Mysql Firewall Rule Id"
  value = azurerm_mysql_firewall_rule.mysql_firewall_rule.id
}
