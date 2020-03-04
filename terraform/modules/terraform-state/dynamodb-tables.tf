# =========================================================================== #
#        Manage DynamoDB tables used for Terraform state locking              #
# =========================================================================== #
# Includes a table in two regions, as well as a global table that handles     #
# data replication between the two tables.                                    #
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
#       "Digest": "f43f2a30525350abciek10kshalbhals",
#       "LockID": "tf-state-bucket/tf-state-prefix/default.tfstate-md5
#     }
#
#   state lock:
#
#     TODO: Add example state lock object ("item" in DynamoDB terms)
#
# =========================================================================== #

resource "aws_dynamodb_table" "tf_state_locks_us-east-1" {
  // Terraform state lock table in the primary region
  billing_mode     = "PROVISIONED"
  hash_key         = "LockID"
  name             = "terraform-state-locks"
  range_key        = null
  read_capacity    = 1
  stream_enabled   = var.tf_state_dynamodb_stream_enabled
  stream_view_type = "NEW_AND_OLD_IMAGES"
  tags             = var.tags
  ttl              = null
  write_capacity   = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  global_secondary_index {
    hash_key           = null
    name               = null
    non_key_attributes = null
    projection_type    = null
    range_key          = null
    read_capacity      = null
    write_capacity     = null
  }

  local_secondary_index {
    name               = null
    non_key_attributes = null
    projection_type    = null
    range_key          = null
  }

  point_in_time_recovery {
    enabled = null
  }

  server_side_encryption {
    # TODO: Create a KMS key specifically for use with DynamoDB
    enabled     = true
    kms_key_arn = null
  }
}

resource "aws_dynamodb_table" "tf_state_locks_us-west-2" {
  // Terraform state lock table in the secondary region
  billing_mode     = "PROVISIONED"
  hash_key         = "LockID"
  name             = "terraform-state-locks"
  range_key        = null
  read_capacity    = 1
  stream_enabled   = var.tf_state_dynamodb_stream_enabled
  stream_view_type = "NEW_AND_OLD_IMAGES"
  tags             = var.tags
  ttl              = null
  write_capacity   = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  global_secondary_index {
    hash_key           = null
    name               = null
    non_key_attributes = null
    projection_type    = null
    range_key          = null
    read_capacity      = null
    write_capacity     = null
  }

  local_secondary_index {
    name               = null
    non_key_attributes = null
    projection_type    = null
    range_key          = null
  }

  point_in_time_recovery {
    enabled = null
  }

  server_side_encryption {
    # TODO: Create a KMS key specifically for use with DynamoDB
    enabled     = true
    kms_key_arn = null
  }
}

resource "aws_dynamodb_global_table" "tf_state_locks_global" {
  // Automatically replicate DynamoDB TF state locking tables across regions
  depends_on = [
    aws_dynamodb_table.terraform_state_locks_us-east-1,
    aws_dynamodb_table.terraform_state_locks_us-west-2,
  ]

  name = "terraform-state-locks"

  replica {
    region_name = "us-east-1"
  }

  replica {
    region_name = "us-west-2"
  }
}
