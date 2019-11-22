resource "azurerm_subnet" "subnet" {
  name = "${var.subnet_name}"
  resource_group_name = "${var.subnet_resource_group_name}"
  virtual_network_name = "${var.subnet_virtual_network_name}"
  address_prefix = "${var.subnet_address_prefix}"
  #network_security_group_id = "${var.subnet_network_security_group_id}"
  #route_table_id = "${var.subnet_route_table_id}"
  service_endpoints = "${var.subnet_service_endpoints}"

  dynamic "delegation" {
    for_each = "${var.subnet_delegation}"

    content {
      name = "${lookup(delegation.value, "name", null)}"

      dynamic "service_delegation" {
        for_each = "${delegation.value.service_delegation}"

        content {
          name = "${lookup(service_delegation.value, "name", null)}"
          actions = "${lookup(service_delegation.value, "actions", null)}"
        }
      }
    }
  }
}
