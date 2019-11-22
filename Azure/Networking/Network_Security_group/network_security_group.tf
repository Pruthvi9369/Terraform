resource "azurerm_network_security_group" "network_security_group" {
  name = "${var.network_security_group_name}"
  resource_group_name = "${var.network_security_group_resource_group_name}"
  location = "${var.network_security_group_location}"
  dynamic "security_rule" {
    for_each = "${var.network_security_group_security_rule}"

    content {
      name = "${lookup(security_rule.value, "name", null)}"
      description = "${lookup(security_rule.value, "description", null)}"
      protocol = "${lookup(security_rule.value, "protocol", null)}"
      source_port_range = "${lookup(security_rule.value, "source_port_range", null)}"
      source_port_ranges = "${split(",", replace(  "${lookup(var.predefined_rules[count.index], "source_port_range", "*" )}"  ,  "*" , "0-65535" ) )}"
      destination_port_range = "${lookup(security_rule.value, "destination_port_range", null)}"
      destination_port_ranges = "${lookup(security_rule.value, "destination_port_ranges", null)}"
      source_address_prefix = "${lookup(security_rule.value, "source_address_prefix", null)}"
      source_address_prefixes = "${lookup(security_rule.value, "source_address_prefixes", null)}"
      source_application_security_group_ids = "${lookup(security_rule.value, "source_application_security_group_ids", null)}"
      destination_address_prefix = "${lookup(security_rule.value, "destination_address_prefix", null)}"
      destination_address_prefixes = "${lookup(security_rule.value, "destination_address_prefixes", null)}"
      destination_application_security_group_ids = "${lookup(security_rule.value, "destination_application_security_group_ids", null)}"
      access = "${lookup(security_rule.value, "access", null)}"
      priority = "${lookup(security_rule.value, "priority", null)}"
      direction = "${lookup(security_rule.value, "direction", null)}"
    }
  }

  tags = "${merge(map(
    "Name", "network_security_group_name",
    "resource_group_name", "network_security_group_resource_group_name",
    ), var.network_security_group_tags)}"
}
