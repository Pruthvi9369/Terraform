variable "mysql_server_name" {
  description = "Please provide mysql server name (Required)"
  type = "string"
  default = ""
}

variable "mysql_server_resource_group_name" {
  description = "Please provide mysql server resource group name (Required)"
  type = "string"
  default = ""
}

variable "mysql_server_location" {
  description = "Please provide mysql server location (Required)"
  type = "string"
  default = ""
}

variable "mysql_server_sku" {
  description = "Please provide mysql server location (Required)"
  type = list(map(string))
  default = []
}

variable "mysql_server_storage_profile" {
  description = "Please provide mysql server storage profile (Required)"
  type = list(map(string))
  default = []
}

variable "mysql_server_administrator_login" {
  description = "Please provide mysql server administrator login (Required)"
  type = "string"
  default = ""
}

variable "mysql_server_administrator_login_password" {
  description = "Please provide mysql server administrator login password (Required)"
  type = "string"
  default = ""
}

variable "mysql_server_version" {
  description = "Please provide mysql server version (Required)"
  type = "string"
  default = ""
}

variable "mysql_server_ssl_enforcement" {
  description = "Please provide mysql sever ssl enforcement (Required)"
  type = "string"
  default = ""
}

variable "mysql_server_tags" {
  description = "Please provide mysql sever tags"
  type = map
  default = {}
}
