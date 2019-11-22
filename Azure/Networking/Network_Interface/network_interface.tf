resource "azurerm_network_interface" "network_interface" {
  name = "${var.network_interface_name}"
  resource_group_name = "${var.network_interface_resource_group_name}"
  location = "${var.network_interface_location}"
  network_security_group_id = "${var.network_interface_network_security_group_id}"
  internal_dns_name_label = "${var.network_interface_internal_dns_name_label}"
  enable_ip_forwarding = "${var.network_interface_enable_ip_forwarding}"
  enable_accelerated_networking = "${var.network_interface_enable_accelerated_networking}"
  dns_servers = "${var.network_interface_dns_servers}"

  dynamic "ip_configuration" {
    for_each = "${var.network_interface_ip_configuration}"

    content {
      name = "${lookup(ip_configuration.value, "name", null)}"
      subnet_id = "${lookup(ip_configuration.value, "subnet_id", null)}"
      private_ip_address = "${lookup(ip_configuration.value, "private_ip_address", null)}"
      private_ip_address_allocation = "${lookup(ip_configuration.value, "private_ip_address_allocation", null)}"
      private_ip_address_version = "${lookup(ip_configuration.value, "private_ip_address_version", null)}"
      public_ip_address_id = "${lookup(ip_configuration.value, "public_ip_address_id", null)}"
      #application_gateway_backend_address_pools_ids = "${lookup(ip_configuration.value, "application_gateway_backend_address_pools_ids", null)}"
      #load_balancer_backend_address_pools_ids = "${lookup(ip_configuration.value, "load_balancer_backend_address_pools_ids", null)}"
      #load_balancer_inbound_nat_rules_ids = "${lookup(ip_configuration.value, "load_balancer_inbound_nat_rules_ids", null)}"
      #application_security_group_ids = "${lookup(ip_configuration.value, "application_security_group_ids", null)}"
      primary = "${lookup(ip_configuration.value, "primary", null)}"
    }
  }

  tags = "${merge(map(
    "Name", "${var.network_interface_name}",
    "resource_group_name", "${var.network_interface_resource_group_name}"
    ), var.network_interface_tags)}"
}
