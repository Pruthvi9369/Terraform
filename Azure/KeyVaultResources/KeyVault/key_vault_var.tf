variable "key_vault_name" {
  description = "Please provide key vault name (Required)"
  type = "string"
  default = ""
}

variable "key_vault_location" {
  description = "Please provide location (Required)"
  type = "string"
  default = ""
}

variable "key_vault_resource_group_name" {
  description = "Please provide resource group name (Required)"
  type = "string"
  default = ""
}

variable "key_vault_sku" {
  description = "Please provide sku"
  type = any
  default = {}
}

variable "key_vault_sku_name" {
  description = "Please provide sku name"
  type = "string"
  default = ""
}

variable "key_vault_tenant_id" {
  description = "Please provide tenant id"
  type = "string"
  default = ""
}

variable "key_vault_access_policy" {
  description = "Please provide access policy"
  type = any
  default = {}
}

variable "key_vault_enabled_for_deployment" {
  description = "Please provide enable for deployment"
  type = bool
  default = false
}

variable "key_vault_enabled_for_disk_encryption" {
  description = "Please provide enable for disk encryption"
  type = bool
  default = false
}

variable "key_vault_enabled_for_template_deployment" {
  description = "Please provide enable for template deployment"
  type = bool
  default = false
}

variable "key_vault_network_acls" {
  description = "Please provide network acls"
  type = any
  default = {}
}

variable "key_vault_tags" {
  description = "Please provide tags"
  type = map
  default = {}
}
