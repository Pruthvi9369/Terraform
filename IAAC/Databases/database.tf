provider "aws" {
  region = "${var.rds_region}"
  version = "2.33"
}

#locals {
#  var.database_subnet_group_name != "" ?  var.database_subnet_group_name : aws_db_subnet_group.rds_subnet_group.id
#}

resource "aws_db_subnet_group" "rds_subnet_group" {
  subnet_ids = "${var.database_subnet_ids}"
  tags = "${merge(map(
    "Name", "${var.database_identifier}-${var.vpc_name}-Subnet_group",
    ), var.rds_subnet_group_tags)}"
}

resource "aws_db_instance" "rds" {
  allocated_storage = "${var.database_storage}"
  allow_major_version_upgrade = "${var.database_major_version_upgrade}"
  apply_immediately = "${var.database_apply_immediately}"
  auto_minor_version_upgrade = "${var.database_minor_version_upgrade}"
  availability_zone = "${var.database_az}"
  backup_retention_period  = "${var.database_backup_retention_period}"
  backup_window = "${var.database_backup_window}"
  character_set_name = "${var.database_character_set_name}"
  copy_tags_to_snapshot = "${var.database_copy_tags_to_snapshot}"
  db_subnet_group_name = "${var.database_subnet_group_name}" != "" ? "${var.database_subnet_group_name}" : "${aws_db_subnet_group.rds_subnet_group.id}"
  deletion_protection = "${var.database_deletion_protection}"
  # domain =
  # domain_iam_role_name =
  enabled_cloudwatch_logs_exports = "${var.database_enabled_cloudwatch_logs_exports}"
  engine = "${var.database_engine}"
  engine_version = "${var.database_engine_version}"
  final_snapshot_identifier  = "${var.database_final_snapshot_identifier}"
  iam_database_authentication_enabled = "${var.database_iam_authentication_enable}"
  identifier = "${var.database_identifier}"
  identifier_prefix = "${var.database_identifier_prefix}"
  instance_class = "${var.database_instance_class}"
  iops = "${var.database_iops}"
  kms_key_id = "${var.database_kms_key_id}"
  license_model = "${var.batabase_license_model}"
  maintenance_window = "${var.database_maintenance_window}"
  max_allocated_storage = "${var.database_max_allocated_storage}"
  monitoring_interval = "${var.database_monitoring_interval}"
  monitoring_role_arn = "${var.database_monitoring_role_arn}"
  multi_az = "${var.database_multi_az}"
  name = "${var.initial_database_name}"
  option_group_name = "${var.database_option_group_name}"
  parameter_group_name = "${var.database_parameter_group_name}"
  password = "${var.database_master_user_password}"
  port = "${var.database_port}"
  publicly_accessible = "${var.database_publicly_accessible}"
  replicate_source_db = "${var.database_replicate_source_db}"
  # security_group_names =
  skip_final_snapshot = "${var.database_skip_final_snapshot}"
  snapshot_identifier = "${var.database_snapshot_identifier}"
  storage_encrypted = "${var.database_storage_encrypted}"
  storage_type = "${var.database_storage_type}"
  tags = "${merge(map(
    "Name", "${var.database_identifier}",
    "engine", "${var.database_engine}",
    ), var.database_tags)}"
  timezone = "${var.database_timezone}"
  username = "${var.database_master_user_name}"
  vpc_security_group_ids = "${var.database_vpc_security_group_ids}"

  #Max 1 block - expiration
  dynamic "s3_import" {
    for_each = "${length(keys(var.database_s3_import)) == 0 ? [] : [var.database_s3_import]}"

    content {
      bucket_name = "${lookup(s3_import.value, "bucket_name", null)}"
      bucket_prefix = "${lookup(s3_import.value, "bucket_prefix", null)}"
      ingestion_role = "${lookup(s3_import.value, "ingestion_role", null)}"
      source_engine = "${lookup(s3_import.value, "source_engine", null)}"
      source_engine_version = "${lookup(s3_import.value, "source_engine_version", null)}"
    }
  }

  performance_insights_enabled  = "${var.database_performance_insights_enabled}"
  performance_insights_kms_key_id = "${var.database_performance_insights_kms_key_id}"
  performance_insights_retention_period  = "${var.database_performance_insights_retention_period}"

  #Max 1 block - expiration
  dynamic "timeouts" {
    for_each = "${length(keys(var.database_timeouts)) == 0 ? [] : [var.database_timeouts]}"

    content {
      create = "${lookup(timeouts.value, "create", null)}"
      update = "${lookup(timeouts.value, "update", null)}"
      delete = "${lookup(timeouts.value, "delete", null)}"
    }
  }
}
