variable "network_profile_name" {
  description = "Please provide network profile name"
  type = "string"
  default = ""
}

variable "network_profile_location" {
  description = "Please provide network profile location"
  type = "string"
  default = ""
}

variable "network_profile_resource_group_name" {
  description = "Please provide network profile resource group name"
  type = "string"
  default = ""
}

variable "network_profile_container_network_interface" {
  description = "Please provide network profile container network interface"
  type = any
  default = []
}

variable "network_profile_tags" {
  description = "Please provide network profile tags"
  type = map
  default = {}
}
