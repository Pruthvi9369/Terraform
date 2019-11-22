variable "subnet_name" {
  description = "Please provide Subnet names (Required)"
  type = "string"
  default = ""
}

variable "subnet_resource_group_name" {
  description = "Please provide subnet resource group name (Required)"
  type = "string"
  default = ""
}

variable "subnet_virtual_network_name" {
  description = "Please provide virtual network name (Required)"
  type = "string"
  default = ""
}

variable "subnet_address_prefix" {
  description = "Please provide address prefix (Required)"
  type = "string"
  default = ""
}

variable "subnet_network_security_group_id" {
  description = "Please provide network security group id"
  type = "string"
  default = null
}

variable "subnet_route_table_id" {
  description = "Please provide route table id"
  type = "string"
  default = null
}

variable "subnet_service_endpoints" {
  description = "Please provide service endpoints"
  type = list
  default = []
}

variable "subnet_delegation" {
  description = "Please provide delegation"
  type = list(map(string))
  default = []
}

#variable "subnet_service_delegation" {
#  description = "Please provide service delegation"
#  type = list(map(string))
#  default = []
#}
