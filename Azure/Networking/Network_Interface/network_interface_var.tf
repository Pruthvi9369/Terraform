variable "network_interface_name" {
  description = "Please provide Network interface Name (Required)"
  type = "string"
  default = ""
}

variable "network_interface_resource_group_name" {
  description = "Please provide Network interface resource group name (Required)"
  type = "string"
  default = ""
}

variable "network_interface_location" {
  description = "Please provide Network interface location (Required)"
  type = "string"
  default = ""
}

variable "network_interface_network_security_group_id" {
  description = "Please provide Network interface network security group id"
  type = "string"
  default = null
}

variable "network_interface_internal_dns_name_label" {
  description = "Please provide Network interface dns name lable"
  type = "string"
  default = null
}

variable "network_interface_enable_ip_forwarding" {
  description = "Please provide Network interface enable ip forwarding"
  type = bool
  default = false
}

variable "network_interface_enable_accelerated_networking" {
  description = "Please provide Network interface enable accelerated networking"
  type = "string"
  default = "false"
}

variable "network_interface_dns_servers" {
  description = "Please provide Network interface dns servers"
  type = list
  default = []
}

variable "network_interface_ip_configuration" {
  description = "Please provide Network interface Name (Required)"
  type = list(map(string))
  default = []
}

variable "network_interface_tags" {
  description = "Please provide Network interface Name (Required)"
  type = map
  default = {}
}
