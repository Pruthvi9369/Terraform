resource "azurerm_public_ip" "public_ip" {
  name = "${var.public_ip_name}"
  resource_group_name = "${var.public_ip_resource_group_name}"
  location = "${var.public_ip_location}"
  sku = "${var.public_ip_sku}"
  allocation_method  = "${var.public_ip_allocation_method}"
  ip_version = "${var.public_ip_ip_version}"
  idle_timeout_in_minutes = "${var.public_ip_idle_timeout_in_minutes}"
  domain_name_label = "${var.public_ip_domain_name_label}"
  reverse_fqdn = "${var.public_ip_reverse_fqdn}"
  public_ip_prefix_id = "${var.public_ip_public_ip_prefix_id}"
  tags = "${merge(map(
    "Name", "${var.public_ip_name}",
    "resource_group_name", "${var.public_ip_resource_group_name}",
    ), var.public_ip_tags)}"
  zones = "${var.public_ip_public_zones}"
}
