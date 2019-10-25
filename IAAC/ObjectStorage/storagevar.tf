variable "bucketname" {
  type = "string"
  default = "063208468694-datadiscovery"
}

variable "bucketprefix" {
  description = "hash numbers are suggested for bucket prefix ex:'4456-7864-5568-1149'"
  type = "string"
  default = null
}

variable "Accesscl" {
  type = "string"
  default = "private"
}

variable "bucket_policy" {
  description = "provide json document for policy"
  type = "string"
  default = null
}

variable "bucket_tags" {
  description = "Bucket Tags"
  type = map(string)
  default = {}
}

variable "bucket_force_destroy" {
  description = "It completely destorys all objcets in bucket and they are not recovered, it a bool value default is false"
  type = "string"
  default = "false"
}

variable "bucket_acceleration_status" {
  type = "string"
  default = null
}

variable "bucket_region" {
  type = "string"
  default = "us-east-1"
}

variable "bucker_request_payer" {
  type = "string"
  default = null
}

variable "bucket_website" {
  description = "If we are planing for static website we need to provide index and error .html files"
  type = map(string)
  default = {}
}

variable "bucket_cors_rule" {
  description = "Bucket Cross Orgin Resoruce Sharing details"
  type = map(string)
  default = {}
}

variable "bucket_versioning" {
  description = "Bucket Versioning"
  type = map(string)
  default = {}
}

variable "bucket_logging" {
  description = "Bucket logging details"
  type = map(string)
  default = {}
}

variable "bucket_lifecycle_rule" {
  description = "Bucket lifecycle rules"
  type = any
  default = []
}

variable "bucket_replication_configuration" {
  type = any
  default = {}
}

variable "bucket_server_side_encryption_configuration" {
  type = any
  default = {}
}

variable "bucket_object_lock_configuration" {
  type = any
  default = {}
}

#063208468694


