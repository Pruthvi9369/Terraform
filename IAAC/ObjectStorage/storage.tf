resource "aws_s3_bucket" "NewBucket" {
  bucket = "${var.bucketname}"
  bucket_prefix = "${var.bucketprefix}"
  acl = "${var.Accesscl}"
  policy = "${var.bucket_policy}"
  tags = "${merge(map(
    "Bucker_Name", "${var.bucketname}",
    "region", "${var.bucket_region}",
    ), var.bucket_tags)}"
  force_destroy  = "${var.bucket_force_destroy}"
  acceleration_status = "${var.bucket_acceleration_status}"
  region = "${var.bucket_region}"
  request_payer = "${var.bucker_request_payer}"

  dynamic "website" {
    for_each = "${length(keys(var.bucket_website))== 0 ? [] : [var.bucket_website]}"

    content {
      index_document = "${lookup(website.value, "index_document", null)}"
      error_document = "${lookup(website.value, "error_document", null)}"
      redirect_all_requests_to = "${lookup(website.value, "redirect_all_requests_to", null)}"
      routing_rules = "${lookup(website.value, "routing_rules", null)}"
    }
  }

  dynamic "cors_rule" {
    for_each = "${length(keys(var.bucket_cors_rule))== 0 ? [] : [var.bucket_cors_rule]}"

    content {
      allowed_headers = "${lookup(cors_rule.value, "allowed_headers", null)}"
      # Note: methods available are GET, PUT, POST, DELETE or HEAD
      allowed_methods = "${lookup(cors_rule.value, "allowed_methods", null)}"
      allowed_origins = "${lookup(cors_rule.value, "allowed_origins", null)}"
      expose_headers = "${lookup(cors_rule.value, "expose_headers", null)}"
      max_age_seconds = "${lookup(cors_rule.value, "max_age_seconds", null)}"
    }
  }

  dynamic "versioning" {
    for_each = "${length(keys(var.bucket_versioning))== 0 ? [] : [var.bucket_versioning]}"

    content {
      enabled = "${lookup(versioning.value, "enabled", null)}"
      # Note: Enable MFA delete for either change the versioning state of your bucket or Permanently delete an object version
      mfa_delete = "${lookup(versioning.value, "mfa_delete", null)}"
    }
  }

  dynamic "logging" {
    for_each = "${length(keys(var.bucket_logging))== 0 ? [] : [var.bucket_logging]}"

    content {
      target_bucket = "${lookup(logging.value, "target_bucket", null)}"
      target_prefix = "${lookup(logging.value, "target_prefix", null)}"
    }
  }

  dynamic "lifecycle_rule" {
    for_each = "${var.bucket_lifecycle_rule}"

    content {
      id = "${lookup(lifecycle_rule.value, "id", null)}"
      prefix = "${lookup(prefix.value, "id", null)}"
      tags = "${lookup(tags.value, "id", null)}"
      enabled = "${lookup(enabled.value, "id", null)}"
      abort_incomplete_multipart_upload_days = "${lookup(abort_incomplete_multipart_upload_days.value, "id", null)}"

      #Max 1 block - expiration
      dynamic "expiration" {
        for_each = "${length(keys(lookup(lifecycle_rule.value, "expiration", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "expiration", {})]}"

        content {
          date = "${lookup(expiration.value, "date", null)}"
          days = "${lookup(expiration.value, "days", null)}"
          expired_object_delete_marker = "${lookup(expiration.value, "expired_object_delete_marker", null)}"
        }
      }

      # Several blocks - transition
      dynamic "transition" {
        for_each = "${lookup(lifecycle_rule.value, "transition", [])}"

        content {
          date = "${lookup(transition.value, "date", null)}"
          days = "${lookup(transition.value, "days", null)}"
          storage_class = "${lookup(transition.value, "storage_class", null)}"
        }
      }

      # Max 1 block - noncurrent_version_expiration
      dynamic "noncurrent_version_expiration" {
        for_each = "${length(keys(lookup(lifecycle_rule.value, "noncurrent_version_expiration", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "noncurrent_version_expiration", {})]}"

        content {
          days = "${lookup(noncurrent_version_expiration.value, "days", null)}"
        }
      }

      # Several blocks - noncurrent_version_transition
      dynamic "noncurrent_version_transition" {
        for_each = "${length(keys(lookup(lifecycle_rule.value, "noncurrent_version_transition", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "noncurrent_version_transition", {})]}"

        content  {
          days = "${lookup(noncurrent_version_transition.value, "days", null)}"
          storage_class = "${lookup(noncurrent_version_transition.value, "days", null)}"
        }
      }
    }
  }

  # Max 1 block - replication_configuration
  dynamic "replication_configuration" {
    for_each = "${length(keys(var.bucket_replication_configuration)) == 0 ? [] : [var.bucket_replication_configuration]}"

    content {
      role = "${replication_configuration.value.role}"

      dynamic "rules" {
        for_each = "${replication_configuration.value.rules}"

        content {
          id = "${lookup(rules.value, id, null)}"
          priority = "${lookup(rules.value, priority, null)}"
          prefix = "${lookup(rules.value, prefix, null)}"
          status = "${lookup(rules.value, status, null)}"

          dynamic "destination" {
            for_each = "${length(keys(lookup(rules.value, "destination", {}))) == 0 ? [] : [lookup(rules.value, "destination", {})]}"

            content {
              bucket = "${lookup(destination.value, "bucket", null)}"
              storage_class = "${lookup(destination.value, "storage_class", null)}"
              replica_kms_key_id = "${lookup(destination.value, "replica_kms_key_id", null)}"
              account_id = "${lookup(destination.value, "account_id", null)}"

              dynamic "access_control_translation" {
                for_each = "${length(keys(lookup(destination.value, "access_control_translation", {}))) == 0 ? [] : [lookup(destination.value, "access_control_translation", {})]}"

                content {
                  owner = "${access_control_translation.value.owner}"
                }

              }
            }
          }

          dynamic "source_selection_criteria" {
            for_each = "${length(keys(lookup(rules.value, "source_selection_criteria", {}))) == 0 ? [] : [lookup(rules.value, "source_selection_criteria", {})]}"

            content {
              dynamic "sse_kms_encrypted_objects" {
                for_each = "${length(keys(lookup(source_selection_criteria.value, "sse_kms_encrypted_objects", {}))) == 0 ? [] : [lookup(source_selection_criteria.value, "sse_kms_encrypted_objects", {})]}"

                content {
                  enabled = "${sse_kms_encrypted_objects.value.enabled}"
                }
              }
            }

          }

          dynamic "filter" {
            for_each = "${length(keys(lookup(rules.value, "filter", {}))) == 0 ? [] : [lookup(rules.value, "filter", {})]}"

            content {
              prefix = "${lookup(filter.value, "prefix", null)}"
              tags = "${lookup(filter.value, "tags", null)}"
            }
          }
        }
      }
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = "${length(keys(var.bucket_server_side_encryption_configuration)) == 0 ? [] : [var.bucket_server_side_encryption_configuration]}"

    content {

      dynamic "rule" {
        for_each = "${length(keys(lookup(server_side_encryption_configuration.value, "rule", {}))) == 0 ? [] : [lookup(server_side_encryption_configuration.value, "rule", {})]}"

        content {

          dynamic "apply_server_side_encryption_by_default" {
            for_each = "${length(keys(lookup(rule.value, "apply_server_side_encryption_by_default", {}))) == 0 ? [] : [lookup(rule.value, "apply_server_side_encryption_by_default", {})]}"

            content {
              sse_algorithm = "${apply_server_side_encryption_by_default.value.sse_algorithm}"
              kms_master_key_id = "${apply_server_side_encryption_by_default.value.kms_master_key_id}"
            }
          }
        }
      }
    }
  }

  dynamic "object_lock_configuration" {
    for_each = "${length(keys(var.bucket_object_lock_configuration)) == 0 ? [] : [var.bucket_object_lock_configuration]}"

    content {
      object_lock_enabled = "${object_lock_configuration.value.object_lock_enabled}"

      dynamic "rule" {
        for_each = "${length(keys(lookup(object_lock_configuration.value, "rule", {}))) == 0 ? [] : [lookup(object_lock_configuration.value, "rule", {})]}"

        content {
          default_retention {
            mode = "${lookup(lookup(rule.value, "default_retention", {}), "mode")}"
            days = "${lookup(lookup(rule.value, "default_retention", {}), "days", null)}"
            years = "${lookup(lookup(rule.value, "default_retention", {}), "years", null)}"
          }
        }
      }
    }
  }
}
