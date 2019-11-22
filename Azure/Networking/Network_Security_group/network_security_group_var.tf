variable "network_security_group_name" {
  description = "Please provide network security group name (Required)"
  type = "string"
  default = ""
}

variable "network_security_group_resource_group_name" {
  description = "Please provide network security group resource group name (Required)"
  type = "string"
  default = ""
}

variable "network_security_group_location" {
  description = "Please provide network security group location (Required)"
  type = "string"
  default = ""
}

variable "network_security_group_security_rule" {
  description = "Please provide network security group security rule"
  type = list(map(string))
  default = []
}

variable "network_security_group_tags" {
  description = "Please provide network security group tags (Required)"
  type = map
  default = {}
}
