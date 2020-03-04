locals {
  // Process YAML configuration
  vars = yamldecode(var.vars)
}

resource "aws_s3_bucket" "main" {
  // S3 bucket used to store Terraform remote state
  bucket        = var.name
  acl           = "private"
  force_destroy = false
  policy        = ""
	region        = var.region
  tags          = var.tags

  versioning {
    enabled = true
  }

  logging {
    target_bucket = var.logging_target_bucket
    target_prefix = var.logging_target_prefix
  }

  lifecycle_rule {
    prefix  = var.lifecycle_rule_prefix
    enabled = var.lifecycle_rule_enabled

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 90
    }
  }

  replication_configuration {
    role = ""

    rules {
      id                        = "foobar"
      prefix                    = "foo"
			priority                  = ""
      status                    = "Enabled"

      destination {
        bucket                     = ""
        storage_class              = "STANDARD"
        replica_kms_key_id         = ""
        account_id                 = ""

        access_control_translation {
          owner = ""
        }
      }

	    source_selection_criteria {
        sse_kms_encrypted_objects {
          enabled = true
        }
      }

      filter {
        prefix = ""
        tags   = ""
      }
    }
  }

  object_lock_configuration {
    object_lock_enabled = true

    rule {
      default_retention {
        mode  = ""
        days  = ""
        years = ""
      }
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = ""
        sse_algorithm     = "aws:kms"
      }
    }
	}

  lifecycle {
    prevent_destroy = true
  }
}
