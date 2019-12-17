resource "azurerm_mysql_firewall_rule" "mysql_firewall_rule" {
  name = "${var.mysql_firewall_rule_name}"
  server_name = "${var.mysql_firewall_rule_server_name}"
  resource_group_name = "${var.mysql_firewall_rule_resource_group_name}"
  start_ip_address = "${var.mysql_firewall_rule_start_ip_address}"
  end_ip_address = "${var.mysql_firewall_rule_end_ip_address}"
}
