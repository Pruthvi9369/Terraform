resource "azurerm_virtual_machine" "virtual_machine" {
  name = "${var.virtual_machine_name}"
  resource_group_name = "${var.virtual_machine_resource_group_name}"
  location = "${var.virtual_machine_location}"
  network_interface_ids = "${var.virtual_machine_network_interface_ids}"

  dynamic "os_profile_linux_config" {
    for_each = "${var.virtual_machine_os_profile_linux_config}"

    content {
      disable_password_authentication = "${lookup(os_profile_linux_config.value, "disable_password_authentication", null)}"

      #dynamic "ssh_keys" {
      #  for_each = "${os_profile_linux_config.value.ssh_keys}"

      #  content {
      #    key_data = "${lookup(ssh_keys.value, "key_data", null)}"
      #    path = "${lookup(ssh_keys.value, "path", null)}"
      #  }
      #}
    }
  }

  dynamic "os_profile_windows_config" {
    for_each = "${var.virtual_machine_os_profile_windows_config}"

    content {
      provision_vm_agent = "${lookup(os_profile_windows_config.value, "provision_vm_agent", null)}"
      enable_automatic_upgrades = "${lookup(os_profile_windows_config.value, "enable_automatic_upgrades", null)}"
      timezone = "${lookup(os_profile_windows_config.value, "timezone", null)}"

      dynamic "winrm" {
        for_each = "${os_profile_windows_config.value.winrm}"

        content {
          protocol = "${lookup(winrm.value, "protocol", null)}"
          certificate_url = "${lookup(winrm.value, "certificate_url", null)}"
        }
      }

      dynamic "additional_unattend_config" {
        for_each = "${os_profile_windows_config.value.additional_unattend_config}"

        content {
          pass = "${lookup(additional_unattend_config.value, "pass", null)}"
          component = "${lookup(additional_unattend_config.value, "component", null)}"
          setting_name = "${lookup(additional_unattend_config.value, "setting_name", null)}"
          content = "${lookup(additional_unattend_config.value, "content", null)}"
        }
      }
    }
  }

  vm_size = "${var.virtual_machine_vm_size}"
  availability_set_id = "${var.virtual_machine_availability_set_id}"

  dynamic "boot_diagnostics" {
    for_each = "${var.virtual_machine_boot_diagnostics}"

    content {
      enabled = "${lookup(boot_diagnostics.value, "enabled", null)}"
      storage_uri = "${lookup(boot_diagnostics.value, "storage_uri", null)}"
    }
  }

  dynamic "additional_capabilities" {
    for_each = "${var.virtual_machine_additional_capabilities}"

    content {
      ultra_ssd_enabled = "${lookup(additional_capabilities.value, "ultra_ssd_enabled", null)}"
    }
  }

  delete_os_disk_on_termination = "${var.virtual_machine_delete_os_disk_on_termination}"
  delete_data_disks_on_termination = "${var.virtual_machine_delete_data_disks_on_termination}"

  dynamic "identity" {
    for_each = "${var.virtual_machine_identity}"

    content {
      type = "${lookup(identity.value, "type", null)}"
      identity_ids = "${lookup(identity.value, "identity_ids", null)}"
    }
  }

  license_type = "${var.virtual_machine_license_type}"

  dynamic "os_profile" {
    for_each = "${var.virtual_machine_os_profile}"

    content {
      computer_name = "${lookup(os_profile.value, "computer_name", null)}"
      admin_username = "${lookup(os_profile.value, "admin_username", null)}"
      admin_password = "${lookup(os_profile.value, "admin_password", null)}"
      custom_data = "${lookup(os_profile.value, "custom_data", null)}"
    }
  }

  dynamic "os_profile_secrets" {
    for_each = "${var.virtaul_machine_os_profile_secrets}"

    content {
      source_vault_id = "${lookup(os_profile_secrets.value, "source_vault_id", null)}"

      dynamic "vault_certificates" {
        for_each = "${os_profile_secrets.value.vault_certificates}"

        content {
          certificate_url = "${lookup(vault_certificates.value, "certificate_url", null)}"
          certificate_store = "${lookup(vault_certificates.value, "certificate_store", null)}"
        }
      }
    }
  }

  dynamic "plan" {
    for_each = "${var.virtual_machine_plan}"

    content {
      name = "${lookup(plan.value, "name", null)}"
      publisher = "${lookup(plan.value, "publisher", null)}"
      product = "${lookup(plan.value, "product", null)}"
    }
  }

  primary_network_interface_id = "${var.virtual_machine_primary_network_interface_id}"
  proximity_placement_group_id = "${var.virtual_machine_proximity_placement_group_id}"

  dynamic "storage_data_disk" {
    for_each = "${var.virtual_machine_storage_data_disk}"

    content {
      name = "${lookup(storage_data_disk.value, "name", null)}"
      caching = "${lookup(storage_data_disk.value, "caching", null)}"
      create_option = "${lookup(storage_data_disk.value, "create_option", null)}"
      disk_size_gb = "${lookup(storage_data_disk.value, "disk_size_gb", null)}"
      lun = "${lookup(storage_data_disk.value, "lun", null)}"
      write_accelerator_enabled = "${lookup(storage_data_disk.value, "write_accelerator_enabled", null)}"
      managed_disk_type = "${lookup(storage_data_disk.value, "managed_disk_type", null)}"
      managed_disk_id = "${lookup(storage_data_disk.value, "managed_disk_id", null)}"
      vhd_uri = "${lookup(storage_data_disk.value, "vhd_uri", null)}"
    }
  }

  dynamic "storage_image_reference" {
    for_each = "${var.virtual_machine_storage_image_reference}"

    content {
      publisher = "${lookup(storage_image_reference.value, "publisher", null)}"
      offer = "${lookup(storage_image_reference.value, "offer", null)}"
      sku = "${lookup(storage_image_reference.value, "sku", null)}"
      version = "${lookup(storage_image_reference.value, "version", null)}"
      id = "${lookup(storage_image_reference.value, "id", null)}"
    }
  }

  dynamic "storage_os_disk" {
    for_each = "${var.virtual_machine_storage_os_disk}"

    content {
      name = "${lookup(storage_os_disk.value, "name", null)}"
      create_option = "${lookup(storage_os_disk.value, "create_option", null)}"
      caching = "${lookup(storage_os_disk.value, "caching", null)}"
      disk_size_gb = "${lookup(storage_os_disk.value, "disk_size_gb", null)}"
      image_uri = "${lookup(storage_os_disk.value, "image_uri", null)}"
      os_type = "${lookup(storage_os_disk.value, "os_type", null)}"
      write_accelerator_enabled = "${lookup(storage_os_disk.value, "write_accelerator_enabled", null)}"
      managed_disk_id = "${lookup(storage_os_disk.value, "managed_disk_id", null)}"
      managed_disk_type = "${lookup(storage_os_disk.value, "managed_disk_type", null)}"
      vhd_uri = "${lookup(storage_os_disk.value, "vhd_uri", null)}"
    }
  }

  tags = "${merge(map(
    "Name", "${var.virtual_machine_name}",
    "resource_group_name", "${var.virtual_machine_resource_group_name}",
    ), var.virtual_machine_tags)}"

  zones = "${var.virtual_machine_zones}"

}
