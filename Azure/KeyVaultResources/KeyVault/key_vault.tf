resource "azurerm_key_vault" "key_vault" {
  name = "${var.key_vault_name}"
  location = "${var.key_vault_location}"
  resource_group_name = "${var.key_vault_resource_group_name}"

  dynamic "sku" {
    for_each = "${var.key_vault_sku}"

    content {
      name = "${lookup(sku.value, "name", null)}"
    }
  }

  sku_name = "${var.key_vault_sku_name}"
  tenant_id = "${var.key_vault_tenant_id}"

  dynamic "access_policy" {
    for_each = "${var.key_vault_access_policy}"

    content {
      tenant_id = "${lookup(access_policy.value, "tenant_id", null)}"
      object_id = "${lookup(access_policy.value, "object_id", null)}"
      application_id = "${lookup(access_policy.value, "application_id", null)}"
      certificate_permissions = "${lookup(access_policy.value, "certificate_permissions", null)}"
      key_permissions = "${lookup(access_policy.value, "key_permissions", null)}"
      secret_permissions = "${lookup(access_policy.value, "secret_permissions", null)}"
      storage_permissions = "${lookup(access_policy.value, "storage_permissions", null)}"
    }
  }

  enabled_for_deployment = "${var.key_vault_enabled_for_deployment}"
  enabled_for_disk_encryption = "${var.key_vault_enabled_for_disk_encryption}"
  enabled_for_template_deployment = "${var.key_vault_enabled_for_template_deployment}"

  dynamic "network_acls" {
    for_each = "${var.key_vault_network_acls}"

    content {
      bypass = "${lookup(network_acls.value, "bypass", null)}"
      default_action = "${lookup(network_acls.value, "default_action", null)}"
      ip_rules = "${lookup(network_acls.value, "ip_rules", null)}"
      virtual_network_subnet_ids = "${lookup(network_acls.value, "virtual_network_subnet_ids", null)}"
    }
  }

  tags = "${merge(map(
    "Name", "${var.key_vault_name}",
    "Resource Group Name", "${var.key_vault_resource_group_name}",
    ), var.key_vault_tags)}"

}
