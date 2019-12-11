variable "container_service_name" {
  description = "Please provide container servive name (Required)"
  type = "string"
  default = ""
}

variable "container_service_resource_group_name" {
  description = "Please provide container servive resource group name (Required)"
  type = "string"
  default = ""
}

variable "container_service_location" {
  description = "Please provide container servive location (Required)"
  type = "string"
  default = ""
}

variable "container_service_admin_enabled" {
  description = "Please provide container servive admin enabled"
  type = "string"
  default = "false"
}

variable "container_service_storage_account_id" {
  description = "Please provide container servive storage account id (Required)"
  type = "string"
  default = ""
}

variable "container_service_sku" {
  description = "Please provide container servive sku"
  type = "string"
  default = ""
}

variable "container_service_tags" {
  description = "Please provide container servive tags"
  type = map
  default = {}
}

variable "container_service_georeplication_locations" {
  description = "Please provide container servive georeplication locations"
  type = "string"
  default = ""
}

variable "container_service_network_rule_set" {
  description = "Please provide container servive network rule set"
  type = list(map(string))
  default = []
}
