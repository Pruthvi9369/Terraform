resource "azurerm_mysql_server" "mysql_server" {
  name = "${var.mysql_server_name}"
  resource_group_name = "${var.mysql_server_resource_group_name}"
  location = "${var.mysql_server_location}"
  dynamic "sku" {
    for_each = "${var.mysql_server_sku}"

    content {
      name = "${lookup(sku.value, "name", null)}"
      capacity = "${lookup(sku.value, "capacity", null)}"
      tier = "${lookup(sku.value, "tier", null)}"
      family = "${lookup(sku.value, "family", null)}"
    }
  }

  dynamic "storage_profile" {
    for_each = "${var.mysql_server_storage_profile}"

    content {
      storage_mb = "${lookup(storage_profile.value, "storage_mb", null)}"
      backup_retention_days = "${lookup(storage_profile.value, "backup_retention_days", null)}"
      geo_redundant_backup = "${lookup(storage_profile.value, "geo_redundant_backup", null)}"
      auto_grow = "${lookup(storage_profile.value, "auto_grow", null)}"
    }
  }

  administrator_login = "${var.mysql_server_administrator_login}"
  administrator_login_password = "${var.mysql_server_administrator_login_password}"
  version = "${var.mysql_server_version}"
  ssl_enforcement = "${var.mysql_server_ssl_enforcement}"
  tags = "${merge(map(
    "Name", "${var.mysql_server_name}",
    "resource_group_name", "${var.mysql_server_resource_group_name}",
    ), var.mysql_server_tags)}"
}
