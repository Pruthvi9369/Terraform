resource "azurerm_route_table" "route_table" {
  name = "${var.route_table_name}"
  location = "${var.route_table_location}"
  resource_group_name = "${var.route_table_resource_group_name}"
  disable_bgp_route_propagation = "${var.route_table_disable_bgp_route_propagation}"

  dynamic "route" {
    for_each = "${var.route_table_route}"

    content {
      name = "${lookup(route.value, "name", null)}"
      address_prefix = "${lookup(route.value, "address_prefix", null)}"
      next_hop_type = "${lookup(route.value, "next_hop_type", null)}"
      next_hop_in_ip_address = "${lookup(route.value, "next_hop_in_ip_address", null)}"
    }
  }

  tags = "${merge(map(
    "Name", "${var.route_table_name}",
    "resource_group_name", "${var.route_table_resource_group_name}",
    ), var.route_table_tags)}"
}
