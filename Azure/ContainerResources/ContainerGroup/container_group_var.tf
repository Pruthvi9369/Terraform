variable "container_group_name" {
  description = "Please provide container group name"
  type = "string"
  default = ""
}

variable "container_group_resource_group_name" {
  description = "Please provide container resource group name"
  type = "string"
  default = ""
}

variable "container_group_location" {
  description = "Please provide container group location"
  type = "string"
  default = ""
}

variable "container_group_identity" {
  description = "Please provide container group identity"
  type = list(map(string))
  default = []
}

variable "container_group_container" {
  description = "Please provide container group container"
  type = any
  default = []
}

variable "container_group_os_type" {
  description = "Please provide container group os type. Linux/Windows"
  type = "string"
  default = ""
}

variable "container_group_diagnostics" {
  description = "Please provide container group diagnostics"
  type = list(map(string))
  default = []
}

variable "container_group_dns_name_label" {
  description = "Please provide container group dns name lable"
  type = "string"
  default = ""
}

variable "container_group_ip_address_type" {
  description = "Please provide container group ip address type. Private/Public"
  type = "string"
  default = ""
}

variable "container_group_network_profile_id" {
  description = "Please provide container group network profile id"
  type = "string"
  default = ""
}

variable "container_group_image_registry_credential" {
  description = "Please provide container group image registry credential"
  type = list(map(string))
  default = []
}

variable "container_group_restart_policy" {
  description = "Please provide container group restart policy"
  type = "string"
  default = "Always"
}

variable "container_group_tags" {
  description = "Please provide container group tags"
  type = map
  default = {}
}
