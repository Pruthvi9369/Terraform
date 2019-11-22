variable "route_table_name" {
  description = "Please provide route table name (Required)"
  type = "string"
  default = ""
}

variable "route_table_location" {
  description = "Please provide route table location (Required)"
  type = "string"
  default = ""
}

variable "route_table_resource_group_name" {
  description = "Please provide resource gorup name for route table (Required)"
  type = "string"
  default = ""
}

variable "route_table_disable_bgp_route_propagation" {
  description = "Please provide bgp route propagation. its bool value, True means disable"
  type = bool
  default = false
}

variable "route_table_route" {
  description = "Please provide route for route table"
  type = list(map(string))
  default = []
}

variable "route_table_tags" {
  description = "Please provide tags for route table"
  type = map
  default = {}
}
