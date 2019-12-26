resource "azurerm_storage_account" "storage_account" {
  name = "${var.storage_account_name}"
  resource_group_name = "${var.storage_account_resource_group_name}"
  location = "${var.storage_account_location}"
  account_kind = "${var.storage_account_account_kind}"
  account_tier = "${var.storage_account_account_tier}"
  account_replication_type = "${var.storage_account_account_replication_type}"
  access_tier = "${var.storage_account_access_tier}"
  enable_blob_encryption = "${var.storage_account_enable_blob_encryption}"
  enable_file_encryption = "${var.storage_account_enable_file_encryption}"
  enable_https_traffic_only = "${var.storage_account_enable_https_traffic_only}"
  is_hns_enabled = "${var.storage_account_is_hns_enabled}"
  account_encryption_source = "${var.storage_account_account_encryption_source}"

  dynamic "custom_domain" {
    for_each = "${var.storage_account_custom_domain}"

    content {
      name = "${lookup(custom_domain.value, "name", null)}"
      use_subdomain = "${lookup(custom_domain.value, "use_subdomain", null)}"
    }
  }

  enable_advanced_threat_protection = "${var.storage_account_enable_advanced_threat_protection}"

  dynamic "identity" {
    for_each = "${var.storage_account_identity}"

    content {
      type = "${lookup(identity.value, "type", null)}"
    }
  }

  dynamic "queue_properties" {
    for_each = "${var.storage_account_queue_properties}"

    content {

      dynamic "cors_rule" {
        for_each = "${queue_properties.value.cors_rule}"

        content {
          allowed_headers = "${lookup(cors_rule.value, "allowed_headers", null)}"
          allowed_methods = "${lookup(cors_rule.value, "allowed_methods", null)}"
          allowed_origins = "${lookup(cors_rule.value, "allowed_origins", null)}"
          exposed_headers = "${lookup(cors_rule.value, "exposed_headers", null)}"
          max_age_in_seconds = "${lookup(cors_rule.value, "max_age_in_seconds", null)}"
        }
      }

      dynamic "logging" {
        for_each = "${queue_properties.value.logging}"

        content {
          delete = "${lookup(logging.value, "delete", null)}"
          read = "${lookup(logging.value, "read", null)}"
          version = "${lookup(logging.value, "version", null)}"
          write = "${lookup(logging.value, "write", null)}"
          retention_policy_days = "${lookup(logging.value, "retention_policy_days", null)}"
        }
      }

      dynamic "minute_metrics" {
        for_each = "${queue_properties.value.minute_metrics}"

        content {
          enabled = "${lookup(minute_metrics.value, "enabled", null)}"
          version = "${lookup(minute_metrics.value, "version", null)}"
          include_apis = "${lookup(minute_metrics.value, "include_apis", null)}"
          retention_policy_days = "${lookup(minute_metrics.value, "retention_policy_days", null)}"
        }
      }

      dynamic "hour_metrics" {
        for_each = "${queue_properties.value.hour_metrics}"

        content {
          enabled = "${lookup(hour_metrics.value, "enabled", null)}"
          version = "${lookup(hour_metrics.value, "version", null)}"
          include_apis = "${lookup(hour_metrics.value, "include_apis", null)}"
          retention_policy_days = "${lookup(hour_metrics.value, "retention_policy_days", null)}"
        }
      }
    }
  }

  dynamic "network_rules" {
    for_each = "${var.storage_account_network_rules}"

    content {
      default_action = "${lookup(network_rules.value, "default_action", null)}"
      bypass = "${lookup(network_rules.value, "bypass", null)}"
      ip_rules = "${lookup(network_rules.value, "ip_rules", null)}"
      virtual_network_subnet_ids = "${lookup(network_rules.value, "virtual_network_subnet_ids", null)}"
    }
  }

  tags = "${merge(map(
    "Name", "${var.storage_account_name}",
    "Resource Group Name", "${var.storage_account_resource_group_name}",
    ), var.storage_account_tags)}"

}
