variable "container_registry_name" {
  description = "Please provide Container Regisgtry Name (Required)"
  type = "string"
  default = ""
}

variable "container_registry_resource_group_name" {
  description = "Please provide Container Regisgtry Resource Group Name (Required)"
  type = "string"
  default = ""
}

variable "container_registry_location" {
  description = "Please provide Container Regisgtry location (Required)"
  type = "string"
  default = ""
}

variable "container_registry_admin_enabled" {
  description = "Please provide Container Regisgtry admin enabled, true/false"
  type = bool
  default = false
}

variable "container_registry_storage_account_id" {
  description = "Please provide Container Regisgtry Storage Account Id (Required for Classic)"
  type = "string"
  default = null
}

variable "container_registry_sku" {
  description = "Please provide Container Regisgtry sku"
  type = "string"
  default = null
}

variable "container_registry_tags" {
  description = "Please provide Container Regisgtry tags"
  type = map
  default = {}
}

variable "container_registry_georeplication_locations" {
  description = "Please provide Container Regisgtry georeplication locations"
  type = list
  default = []
}

variable "container_registry_network_rule_set" {
  description = "Please provide Container Regisgtry georeplication locations"
  type = any
  default = []
}
