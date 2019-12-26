variable "storage_account_name" {
  description = "Please provide Name for Storage Account (Required)"
  type = "string"
  default = ""
}

variable "storage_account_resource_group_name" {
  description = "Please provide Resource group name for Storage Account (Required)"
  type = "string"
  default = ""
}

variable "storage_account_location" {
  description = "Please provide Location for Storage Account (Required)"
  type = "string"
  default = ""
}

variable "storage_account_account_kind" {
  description = "Please provide Account Kind for Storage Account, expected('BlobStorage', 'BlockBlobStorage', 'FileStorage', 'Storage', 'StorageV2')"
  type = "string"
  default = "Storage"
}

variable "storage_account_account_tier" {
  description = "Please provide Account tier for Storage Account (Required), expected('Standard', 'Premium')"
  type = "string"
  default = ""
}

variable "storage_account_account_replication_type" {
  description = "Please provide Replication Type for Storage Account (Required), expected('LRS', 'GRS', 'RAGRS', 'ZRS')"
  type = "string"
  default = "RAGRS"
}

variable "storage_account_access_tier" {
  description = "Please provide Access Tier for Storage Account,  expected('Hot', 'Cool')"
  type = "string"
  default = "Hot"
}

variable "storage_account_enable_blob_encryption" {
  description = "Please provide Enable Blob Encryption for Storage Account"
  type = bool
  default = true
}

variable "storage_account_enable_file_encryption" {
  description = "Please provide Enable File Encryption for Storage Account"
  type = bool
  default = true
}

variable "storage_account_enable_https_traffic_only" {
  description = "Please provide Enable Https Traffic Only for Storage Account"
  type = bool
  default = false
}

variable "storage_account_is_hns_enabled" {
  description = "Please provide is hns enabled for Storage Account"
  type = bool
  default = false
}

variable "storage_account_account_encryption_source" {
  description = "Please provide account encryption source for Storage Account, expected('Microsoft.Keyvault', 'Microsoft.Storage')"
  type = "string"
  default = "Microsoft.Storage"
}

variable "storage_account_custom_domain" {
  description = "Please provide custom domain for Storage Account"
  type = any
  default = {}
}

variable "storage_account_enable_advanced_threat_protection" {
  description = "Please provide enable advanced threat protection for Storage Account"
  type = bool
  default = false
}

variable "storage_account_identity" {
  description = "Please provide identity for Storage Account"
  type = any
  default = {}
}

variable "storage_account_queue_properties" {
  description = "Please provide queue properties for Storage Account"
  type = any
  default = {}
}

variable "storage_account_network_rules" {
  description = "Please provide Network Rules for Storage Account"
  type = any
  default = {}
}

variable "storage_account_tags" {
  description = "Please provide tags for Storage Account (Required)"
  type = map
  default = {}
}
