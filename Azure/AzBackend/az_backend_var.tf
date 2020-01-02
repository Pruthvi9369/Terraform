variable "az_backend_storage_account_name" {
  description = "Please provide Storage Account Name for Az Backend (Required)"
  type = "string"
  default = ""
}

variable "az_backend_container_name" {
  description = "Please provide Container Name for Az Backend (Required)"
  type = "string"
  default = ""
}

variable "az_backend_key" {
  description = "Please provide key for Az Backend (Required)"
  type = "string"
  default = ""
}

variable "az_backend_environment" {
  description = "Please provide key for Az Backend, Expected ('public', 'china', 'german', 'stack', 'usgovernment')"
  type = "string"
  default = "public"
}

variable "az_backend_endpoint" {
  description = "Please provide endpoint for Az Backend"
  type = "string"
  default = ""
}

variable "az_backend_subscription_id" {
  description = "Please provide Subscription Id for Az Backend"
  type = "string"
  default = ""
}

variable "az_backend_tenant_id" {
  description = "Please provide Tenant Id for Az Backend"
  type = "string"
  default = ""
}

variable "az_backend_msi_endpoint" {
  description = "Please provide MSI EndPoint for Az Backend"
  type = "string"
  default = ""
}

variable "az_backend_use_msi" {
  description = "Please provide Use MSI for Az Backend"
  type = "string"
  default = ""
}

variable "az_backend_sas_token" {
  description = "Please provide SAS Token for Az Backend"
  type = "string"
  default = ""
}

variable "az_backend_access_key" {
  description = "Please provide Access Key for Az Backend"
  type = "string"
  default = ""
}

variable "az_backend_resource_group_name" {
  description = "Please provide Resource Group Name for Az Backend (Required). In which storage account exist"
  type = "string"
  default = "rg-ss-dev-01"
}

variable "az_backend_client_id" {
  description = "Please provide Client Id for Az Backend"
  type = "string"
  default = ""
}

variable "az_backend_client_secret" {
  description = "Please provide Client Secret for Az Backend"
  type = "string"
  default = ""
}
