variable "network_security_rule_name" {
  description = "Please provide Network Security Rule name (Required)"
  type = "string"
  default = ""
}

variable "network_security_rule_resource_group_name" {
  description = "Please provide Network Security Rule Resource Group name (Required)"
  type = "string"
  default = ""
}

variable "network_security_rule_network_security_group_name" {
  description = "Please provide Network Security Rule Security group name (Required)"
  type = "string"
  default = ""
}

variable "network_security_rule_description" {
  description = "Please provide Network Security Rule description  (Required)"
  type = "string"
  default = ""
}

variable "network_security_rule_protocol" {
  description = "Please provide Network Security Rule protocol (Required)"
  type = "string"
  default = "*"
}

variable "network_security_rule_source_port_range" {
  description = "Please provide Network Security Rule Source port range (Required)"
  type = "string"
  default = "*"
}

#variable "network_security_rule_source_port_ranges" {
#  description = "Please provide Network Security Rule Source port range (Required)"
#  type = list
#  default = []
#}

variable "network_security_rule_destination_port_range" {
  description = "Please provide Network Security Rule Description port range (Required)"
  type = "string"
  default = "*"
}

#variable "network_security_rule_destination_port_ranges" {
#  description = "Please provide Network Security Rule Description port ranges (Required)"
#  type = list
#  default = []
#}

variable "network_security_rule_source_address_prefix" {
  description = "Please provide Network Security Rule source address prefix (Required)"
  type = "string"
  default = "*"
}

#variable "network_security_rule_source_address_prefixes" {
#  description = "Please provide Network Security Rule source address prefixs (Required)"
#  type = list
#  default = []
#}

variable "network_security_rule_source_application_security_group_ids" {
  description = "Please provide Network Security Rule source application security group id's (Required)"
  type = list
  default = []
}

variable "network_security_rule_destination_address_prefix" {
  description = "Please provide Network Security Rule destination address prefix (Required)"
  type = "string"
  default = "*"
}

#variable "network_security_rule_destination_address_prefixes" {
#  description = "Please provide Network Security Rule destination address prefixs (Required)"
#  type = list
#  default = []
#}

variable "network_security_rule_destination_application_security_group_ids" {
  description = "Please provide Network Security Rule destination application security group ids (Required)"
  type = list
  default = []
}

variable "network_security_rule_access" {
  description = "Please provide Network Security Rule access Allow/Deny (Required)"
  type = "string"
  default = ""
}

variable "network_security_rule_priority" {
  description = "Please provide Network Security Rule priority, The value can be between 100 and 4096 (Required)"
  type = "string"
  default = ""
}

variable "network_security_rule_direction" {
  description = "Please provide Network Security Rule Direction, Inbound or Outbound traffic (Required)"
  type = "string"
  default = ""
}
