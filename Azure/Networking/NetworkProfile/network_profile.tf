resource "azurerm_network_profile" "network_profile" {
  name = "${var.network_profile_name}"
  location = "${var.network_profile_location}"
  resource_group_name= "${var.network_profile_resource_group_name}"

  dynamic "container_network_interface" {
    for_each = "${var.network_profile_container_network_interface}"

    content {
      name = "${lookup(container_network_interface.value, "name", null)}"

      dynamic "ip_configuration" {
        for_each = "${length(keys(lookup(container_network_interface.value, "ip_configuration", {}))) == 0 ? [] : [lookup(container_network_interface.value, "ip_configuration", {})]}"

        content {
          name = "${lookup(ip_configuration.value, "name", null)}"
          subnet_id = "${lookup(ip_configuration.value, "subnet_id", null)}"
        }
      }
    }
  }

  tags = "${merge(map(
    "Name", "${var.network_profile_name}",
    "resource_group_name", "${var.network_profile_resource_group_name}",
    ), var.network_profile_tags)}"
}
