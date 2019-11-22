variable "public_ip_name" {
  description = "Please provide public ip's name (Required)"
  type = "string"
  default = ""
}

variable "public_ip_resource_group_name" {
  description = "Please provide public ip's Resource Group name (Required)"
  type = "string"
  default = ""
}

variable "public_ip_location" {
  description = "Please provide public ip's location (Required)"
  type = "string"
  default = ""
}

variable "public_ip_sku" {
  description = "Please provide public ip's sku"
  type = "string"
  default = null
}

variable "public_ip_allocation_method" {
  description = "Please provide public ip's allocation method Dynamic/Static (Required)"
  type = "string"
  default = "Static"
}

variable "public_ip_ip_version" {
  description = "Please provide public ip's ip version IPv6/IPv4"
  type = "string"
  default = "IPv4"
}

variable "public_ip_idle_timeout_in_minutes" {
  description = "Please provide public ip's idle tiomout in minutes"
  type = "string"
  default = null
}

variable "public_ip_domain_name_label" {
  description = "Please provide public ip's domain name label"
  type = "string"
  default = null
}

variable "public_ip_reverse_fqdn" {
  description = "Please provide public ip's reverse fqdn"
  type = "string"
  default = null
}

variable "public_ip_public_ip_prefix_id" {
  description = "Please provide public ip's prefix id"
  type = "string"
  default = null
}

variable "public_ip_tags" {
  description = "Please provide public ip's prefix id"
  type = map
  default = {}
}

variable "public_ip_public_zones" {
  description = "Please provide public ip's zones"
  type = list
  default = []
}
