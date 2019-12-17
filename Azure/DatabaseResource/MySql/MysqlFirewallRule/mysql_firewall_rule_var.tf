variable "mysql_firewall_rule_name" {
  description = "Please provide mysql firewall rule name"
  type = "string"
  default = ""
}

variable "mysql_firewall_rule_server_name" {
  description = "Please provide mysql firewall rule server name"
  type = "string"
  default = ""
}

variable "mysql_firewall_rule_resource_group_name" {
  description = "Please provide mysql firewall rule resource group name"
  type = "string"
  default = ""
}

variable "mysql_firewall_rule_start_ip_address" {
  description = "Please provide mysql firewall rule start ip address"
  type = "string"
  default = ""
}

variable "mysql_firewall_rule_end_ip_address" {
  description = "Please provide mysql firewall rule end ip address"
  type = "string"
  default = ""
}
