resource "azurerm_container_group" "container_group" {
  name = "${var.container_group_name}"
  resource_group_name = "${var.container_group_resource_group_name}"
  location = "${var.container_group_location}"

  dynamic "identity" {
    for_each = "${var.container_group_identity}"

    content {
      type = "${lookup(identity.value, "type", null)}"
      identity_ids = "${lookup(identity.value, "identity_ids", null)}"
    }
  }

  dynamic "container" {
    for_each = "${var.container_group_container}"

    content {
      name = "${lookup(container.value, "name", null)}"
      image = "${lookup(container.value, "image", null)}"
      cpu = "${lookup(container.value, "cpu", null)}"
      memory = "${lookup(container.value, "memory", null)}"

      dynamic "gpu" {
        for_each = "${length(keys(lookup(container.value, "gpu", {}))) == 0 ? [] : [lookup(container.value, "gpu", {})]}"

        content {
          count = "${lookup(gpu.value, "count", null)}"
          sku = "${lookup(gpu.value, "sku", null)}"
        }
      }

      dynamic "ports" {
        for_each = "${length(keys(lookup(container.value, "ports", {}))) == 0 ? [] : [lookup(container.value, "ports", {})]}"

        content {
          port = "${lookup(ports.value, "port", null)}"
          protocol = "${lookup(ports.value, "protocol", null)}"
        }
      }
      environment_variables = "${lookup(container.value, "environment_variables", null)}"
      secure_environment_variables = "${lookup(container.value, "secure_environment_variables", null)}"

      dynamic "readiness_probe" {
        for_each = "${length(keys(lookup(container.value, "readiness_probe", {}))) == 0 ? [] : [lookup(container.value, "readiness_probe", {})]}"

        content {
          exec = "${lookup(readiness_probe.value, "exec", null)}"

          #dynamic "httpget" {
          #  for_each = "  ${length(keys(lookup(readiness_probe.value, "httpget", {}))) == 0 ? [] : [lookup(readiness_probe.value, "httpget", {})]}"

          #  content {
          #    path = "${lookup(httpget.value, "path", null)}"
          #    port = "${lookup(httpget.value, "port", null)}"
          #    scheme = "${lookup(httpget.value, "scheme", null)}"
          #  }
          #}

          #httpget = "${lookup(readiness_probe.value, "httpget", {})}"
          initial_delay_seconds = "${lookup(readiness_probe.value, "initial_delay_seconds", null)}"
          period_seconds = "${lookup(readiness_probe.value, "period_seconds", null)}"
          failure_threshold = "${lookup(readiness_probe.value, "failure_threshold", null)}"
          success_threshold = "${lookup(readiness_probe.value, "success_threshold", null)}"
          timeout_seconds = "${lookup(readiness_probe.value, "timeout_seconds", null)}"
        }
      }

      dynamic "liveness_probe" {
        for_each = "${length(keys(lookup(container.value, "liveness_probe", {}))) == 0 ? [] : [lookup(container.value, "liveness_probe", {})]}"

        content {
          exec = "${lookup(liveness_probe.value, "exec", null)}"

          #dynamic "httpget" {
          #  for_each = "${container.value.liveness_probe.value.httpget}"

          #  content {
          #    path = "${lookup(httpget.value, "path", null)}"
          #    port = "${lookup(httpget.value, "port", null)}"
          #    scheme = "${lookup(httpget.value, "scheme", null)}"
          #  }
          #}

          #httpget = "${lookup(liveness_probe.value, "httpget", {})}"
          initial_delay_seconds = "${lookup(liveness_probe.value, "initial_delay_seconds", null)}"
          period_seconds = "${lookup(liveness_probe.value, "period_seconds", null)}"
          failure_threshold = "${lookup(liveness_probe.value, "failure_threshold", null)}"
          success_threshold = "${lookup(liveness_probe.value, "success_threshold", null)}"
          timeout_seconds = "${lookup(liveness_probe.value, "timeout_seconds", null)}"
        }
      }

      command = "${lookup(container.value, "command", null)}"
      commands = "${lookup(container.value, "commands", null)}"

      dynamic "volume" {
        for_each = "${length(keys(lookup(container.value, "volume", {}))) == 0 ? [] : [lookup(container.value, "volume", {})]}"

        content {
          name = "${lookup(volume.value, "name", null)}"
          mount_path = "${lookup(volume.value, "mount_path", null)}"
          read_only = "${lookup(volume.value, "read_only", null)}"
          storage_account_name = "${lookup(volume.value, "storage_account_name", null)}"
          storage_account_key = "${lookup(volume.value, "storage_account_key", null)}"
          share_name = "${lookup(volume.value, "share_name", null)}"
        }
      }
    }
  }

  os_type = "${var.container_group_os_type}"

  dynamic "diagnostics" {
    for_each = "${var.container_group_diagnostics}"

    content {

      dynamic "log_analytics" {
        for_each = "${diagnostics.value.log_analytics}"

        content {
          log_type  = "${lookup(log_analytics.value, "log_type", null)}"
          workspace_id = "${lookup(log_analytics.value, "workspace_id", null)}"
          workspace_key = "${lookup(log_analytics.value, "workspace_key", null)}"
          metadata = "${lookup(log_analytics.value, "metadata", null)}"
        }
      }
    }
  }

  #dns_name_label = "${var.container_group_dns_name_label}"
  ip_address_type = "${var.container_group_ip_address_type}"
  network_profile_id = "${var.container_group_network_profile_id}"

  dynamic "image_registry_credential" {
    for_each = "${var.container_group_image_registry_credential}"

    content {
      username = "${lookup(image_registry_credential.value, "username", null)}"
      password = "${lookup(image_registry_credential.value, "password", null)}"
      server = "${lookup(image_registry_credential.value, "server", null)}"
    }
  }

  restart_policy = "${var.container_group_restart_policy}"
  tags = "${merge(map(
    "Name", "${var.container_group_name}",
    "resource_group_name", "${var.container_group_resource_group_name}",
    ), var.container_group_tags)}"
}
