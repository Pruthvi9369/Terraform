terraform {
  backend "azurerm" {
    storage_account_name = "${var.az_backend_storage_account_name}"
    container_name = "${var.az_backend_container_name}"
    key = "${var.az_backend_key}"
    environment = "${var.az_backend_environment}"
    endpoint = "${var.az_backend_endpoint}"
    subscription_id = "${var.az_backend_subscription_id}"
    tenant_id = "${var.az_backend_tenant_id}"
    msi_endpoint = "${var.az_backend_msi_endpoint}"
    use_msi = "${var.az_backend_use_msi}"
    sas_token = "${var.az_backend_sas_token}"
    access_key = "${var.az_backend_access_key}"
    resource_group_name = "${var.az_backend_resource_group_name}"
    client_id = "${var.az_backend_client_id}"
    client_secret = "${var.az_backend_client_secret}"
  }
}
