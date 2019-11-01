/*
Please provide below details to create your database, If not it creates default database
##########
database_engine
database_engine_version
database_identifier
database_instance_class
database_az # if public please provide public az
initial_database_name
database_master_user_name
database_master_user_password
database_port
database_publicly_accessible
database_final_snapshot_identifier
##########
database_storage
database_az
database_instance_class
database_skip_final_snapshot
database_storage_type
database_vpc_security_group_ids
*/

variable "rds_region" {
  description = "Region to create RDS"
  type = "string"
  default = "us-east-1"
}

# Note: We cannot use version as variable
#variable "provider_version" {
#  description = "Provider or Terraform version"
#  type = "string"
#  default = "2.33"
#}

variable "vpc_name" {
  description = "VPC name in which we create this database"
  type = "string"
  default = "management"
}

variable "database_subnet_ids" {
  description = "Provide subnet's to create subnet group id"
  type = list(string)
  default = ["subnet-0508810222f7402b9", "subnet-0a57be36cc1eaf5de", "subnet-0d5abc3634a3e2e69"]
}

variable "rds_subnet_group_tags" {
  description = "RDS subnet group tags"
  type = map
  default = {}
}

variable "database_storage" {
  description = "Database storage size"
  type = "string"
  default = "20"
}

variable "database_major_version_upgrade" {
  description = "Database Major Version Upgrade"
  type = bool
  default = false
}

variable "database_apply_immediately" {
  description = "Modifications are applied immediately"
  type = bool
  default = false
}

variable "database_minor_version_upgrade" {
  description = "Database Minor version upgrades"
  type = bool
  default = false
}

variable "database_az" {
  description = "Database availability zone"
  type = "string"
  default = ""
}

variable "database_backup_retention_period" {
  description = "Database backup retention period and it must be between 0 to 35 days and grater the 0 and default is 7 days"
  type = number
  default = 7
}

variable "database_backup_window" {
  description = "Database backup window by with automatic backups are created and default backup time varies with region. Must not overlap with maintenance_window and they are in UTC"
  type = "string"
  default = ""
}

variable "database_character_set_name" {
  description = "Character set name to use for DB encoding in Oracle Instance"
  type = "string"
  default = ""
}

variable "database_copy_tags_to_snapshot" {
  description = "Copy database tags to snapshots"
  type = bool
  default = false
}

variable "database_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group"
  type = "string"
  default = ""
}

variable "database_deletion_protection" {
  description = "Database deletion protection"
  type = bool
  default = false
}

variable "database_enabled_cloudwatch_logs_exports" {
  description = "Database Enabled Cloudwatch logs exports"
  type = list(string)
  default = []
}

variable "database_engine" {
  description = "Database Engin"
  type = "string"
  default = "MySQL"
}

variable "database_engine_version" {
  description = "Database Engine Version"
  type = "string"
  default = "5.7.22"
}

variable "database_final_snapshot_identifier" {
  description = "Name of Database final snapshot when this database instance is deleted "
  type = "string"
  default = "terraformtestdb-snapshot"
}

variable "database_iam_authentication_enable" {
  description = "IAM users authentication to database"
  type = bool
  default = false
}

variable "database_identifier" {
  description = "Database Identifier"
  type = "string"
  default = "terraformtestdb"
}

variable "database_identifier_prefix" {
  description = "Database Identifier prefix"
  type = "string"
  default = null
}

variable "database_instance_class" {
  description = "Instance type for RDS/ Database instance"
  type = "string"
  default = "db.t2.micro"
}

variable "database_iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  type = number
  default = 0
}

variable "database_kms_key_id" {
  description = "Database KMS Encryptio ARN"
  type = "string"
  default = ""
}

variable "batabase_license_model" {
  description = "License model information for this DB instance. it requires  for some DB engines, i.e. Oracle SE1"
  type = "string"
  default = ""
}

variable "database_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'."
  type = "string"
  default = ""
}

variable "database_max_allocated_storage" {
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance"
  type = number
  default = 0
}

variable "database_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  type = number
  default = 0
}

variable "database_monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type = "string"
  default = ""
}

variable "database_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type = bool
  default = false
}

variable "initial_database_name" {
  description = "The name of the database to create when the DB instance is created"
  type = "string"
  default = "Terraform_Test_db_initial"
}

variable "database_option_group_name" {
  description = "Name of the DB option group to associate"
  type = "string"
  default = ""
}

variable "database_parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type = "string"
  default = ""
}

variable "database_master_user_password" {
  description = "Password for the master DB user"
  type = "string"
  default = "TerraformTest"
}

variable "database_port" {
  description = "The port on which the DB accepts connections"
  type = "string"
  default = "3306"
}

variable "database_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type = bool
  default = true
}

variable "database_replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database"
  type = "string"
  default = null
}

variable "database_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type = bool
  default = false
}

variable "database_snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot"
  type = "string"
  default = null
}

variable "database_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type = bool
  default = false
}

variable "database_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not."
  type = "string"
  default = "gp2"
}

variable "database_tags" {
  description = "Database tags"
  type = map
  default = {}
}

variable "database_timezone" {
  description = "Time zone of the DB instance"
  type = "string"
  default = ""
}

variable "database_master_user_name" {
  description = "Username for the master DB user"
  type = "string"
  default = "TerraformTest"
}

variable "database_vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type = list(string)
  default = ["sg-0452634bfa39c5f94"]
}

variable "database_s3_import" {
  description = "Restore from a Percona Xtrabackup in S3"
  type = map(string)
  default = {}
}

variable "database_performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type = bool
  default = false
}

variable "database_performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type = "string"
  default = ""
}

variable "database_performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years)."
  type = number
  default = null
}

variable "database_timeouts" {
  description = "provides the following Timeouts configuration options"
  type = map(string)
  default = {
    create = "40m"
    update = "80m"
    delete = "40m"
  }
}
