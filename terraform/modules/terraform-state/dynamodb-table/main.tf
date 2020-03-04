# =========================================================================== #
#          Manage DynamoDB table used for Terraform state locking             #
# =========================================================================== #
# Manages a table with the appropriate attributes defined for Terraform state #
# lock objects and state file checksums.                                      #
#                                                                             #
# Terraform uses this table to persist the md5 hashes of known state files    #
# and to track in-progress Terraform runs by creating state locks. This       #
# ensures that state cannot be modified by more than one Terraform process at #
# a time.                                                                     #
# --------------------------------------------------------------------------- #
#
# NOTES
# -----
#
# Data format for state lock items in DynamoDB:
#
#   md5 hash of state file:
#
#     {
#       "Digest": "01234567890123456789012345678901",
#       "LockID": "tf-state-bucket/tf-state-prefix/default.tfstate-md5
#     }
#
#   state lock:
#
#     TODO: Add example state lock object ("item" in DynamoDB terms)
#
# =========================================================================== #

resource "aws_dynamodb_table" "main" {
  billing_mode     = var.billing_mode
  hash_key         = var.hash_key
  name             = var.name
  range_key        = var.range_key
  read_capacity    = var.read_capacity
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type
  tags             = var.tags
  write_capacity   = var.write_capacity

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  # Not customizable for this module.
  global_secondary_index {
    hash_key           = null
    name               = null
    non_key_attributes = null
    projection_type    = null
    range_key          = null
    read_capacity      = null
    write_capacity     = null
  }

  # Not customizable for this module.
  local_secondary_index {
    name               = null
    non_key_attributes = null
    projection_type    = null
    range_key          = null
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic replica {
    for_each = var.replica_regions
    iterator = iter

    content {
      region_name = iter.value
    }
  }

  # TODO: Find out if Terraform supports encrypted tables for remote state.
  server_side_encryption {
    enabled     = var.server_side_enabled
    kms_key_arn = var.server_side_kms_key_arn
  }

  # This option most likely never needs to be used:
  # - Is there a scenario with Terraform state locks that TTL would make any sense?
  # - If so, wouldn't Terraform need to add TTL values to each table item?
  # - TTL values are used on a per-item basis.
  ttl {
    enabled        = var.ttl_enabled
    attribute_name = var.ttl_attribute_name
  }
}
