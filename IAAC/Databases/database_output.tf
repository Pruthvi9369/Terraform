output "rds_subnet_group_id" {
  description = "Id for subnet group created with list of subnets"
  value = aws_db_subnet_group.rds_subnet_group.id
}

output "rds_subnet_group_arn" {
  description = "ARN for subnet group created with list of subnets"
  value = aws_db_subnet_group.rds_subnet_group.arn
}

output "database_address" {
  description = "The hostname of the RDS instance. See also endpoint and port"
  value = aws_db_instance.rds.address
}

output "database_arn" {
  description = "The ARN of the RDS instance"
  value = aws_db_instance.rds.arn
}

output "database_allocated_storage" {
  description = "The amount of allocated storage"
  value = aws_db_instance.rds.allocated_storage
}

output "database_availability_zone" {
  description = "The availability zone of the instance"
  value = aws_db_instance.rds.availability_zone
}

output "database_backup_retention_period" {
  description = "The backup retention period"
  value = aws_db_instance.rds.backup_retention_period
}

output "database_backup_window" {
  description = "The backup window"
  value = aws_db_instance.rds.backup_window
}

output "database_ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  value = aws_db_instance.rds.ca_cert_identifier
}

output "database_domain" {
  description = "The ID of the Directory Service Active Directory domain the instance is joined to"
  value = aws_db_instance.rds.domain
}

output "database_domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service"
  value = aws_db_instance.rds.domain_iam_role_name
}

output "database_endpoint" {
  description = "The connection endpoint in address:port format"
  value = aws_db_instance.rds.endpoint
}

output "database_engine" {
  description = "The database engine"
  value = aws_db_instance.rds.engine
}

output "database_engine_version" {
  description = "The database engine version"
  value = aws_db_instance.rds.engine_version
}

output "database_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)."
  value = aws_db_instance.rds.hosted_zone_id
}

output "database_id" {
  description = "The RDS instance ID"
  value = aws_db_instance.rds.id
}

output "database_instance_class" {
  description = "The RDS instance class"
  value = aws_db_instance.rds.instance_class
}

output "database_maintenance_window" {
  description = "The instance maintenance window"
  value = aws_db_instance.rds.maintenance_window
}

output "database_multi_az" {
  description = "If the RDS instance is multi AZ enabled"
  value = aws_db_instance.rds.multi_az
}

output "database_name" {
  description = "The database name"
  value = aws_db_instance.rds.name
}

output "database_port" {
  description = "The database port"
  value = aws_db_instance.rds.port
}

output "database_resource_id" {
  description = "The RDS Resource ID of this instance"
  value = aws_db_instance.rds.resource_id
}

output "database_status" {
  description = "The RDS instance status"
  value = aws_db_instance.rds.status
}

output "database_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  value = aws_db_instance.rds.storage_encrypted
}

output "database_username" {
  description = "The master username for the database"
  value = aws_db_instance.rds.username
}

output "database_character_set_name" {
  description = "The character set used on Oracle instances"
  value = aws_db_instance.rds.character_set_name
}
