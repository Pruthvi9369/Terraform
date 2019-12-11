resource "azurerm_container_registry" "container_service" {
  name = "${var.container_service_name}"
  resource_group_name = "${var.container_service_resource_group_name}"
  location = "${var.container_service_location}"
  admin_enabled = "${var.container_service_admin_enabled}"
  storage_account_id = "${var.container_service_storage_account_id}"
  sku = "${var.container_service_sku}"
  tags = "${merge(map(
    "Name", "${var.container_service_name}",
    "resource_group_name", "${var.container_service_resource_group_name}"
    ), var.container_service_tags)}"
  georeplication_locations = "${var.container_service_georeplication_locations}"

  dynamic "network_rule_set" {
    for_each = "${var.container_service_network_rule_set}"

    content {
      default_action = "${lookup(network_rule_set.value, "default_action", null)}"

      dynamic "ip_rule" {
        for_each = "${network_rule_set.value.ip_rule}"

        content {
          action = "${lookup(ip_rule.value, "action", null)}"
          ip_range = "${lookup(ip_rule.value, "ip_range", null)}"
        }
      }

      dynamic "virtual_network" {
        for_each = "${network_rule_set.value.virtual_network}"

        content {
          action = "${lookup(virtual_network.value, "action", null)}"
          subnet_id = "${lookup(virtual_network.value, "subnet_id", null)}"
        }
      }
    }
  }
}
