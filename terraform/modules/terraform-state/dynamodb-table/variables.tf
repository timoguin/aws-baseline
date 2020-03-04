variable "billing_mode" {
  description = "Billing mode for the table"
  type        = string
  default     = "PROVISIONED"
}

variable "hash_key" {
  description = "The hash key (primary) for the table (Terraform uses LockID)"
  type        = string
  default     = "LockID"
}

variable "hash_key_type" {
  description = "The DynamoDB type used for the hash key (Terraform uses a string)"
  type        = string
  default     = "S"
}

variable "name" {
  description = "The name of the table"
  type        = string
  default     = "terraform-state-locks"
}

variable "point_in_time_recovery_enabled" {
  description = "Enables point-in-time recovery for the tables if set to true"
  type        = bool
  default     = null
}

variable "range_key" {
  description = "The attribute to use as the sort key"
  type        = string
  default     = null
}

variable "read_capacity" {
  description = "Number of read capacity units to provision for the tables"
  type        = number
  default     = 1
}

variable "replica_regions" {
  description = "A list of regions to replicate the table (Global Tables v2)"
  type        = set(string)
  default     = ("us-east-1", "us-east-2", "us-west-2")
}

variable "server_side_encryption_enabled" {
  description = "Enables server-side encryption with KMS if set to true"
  type        = bool
  default     = null
}

variable "server_side_encryption_kms_key_arn" {
  description = "The ARN of the KMS key used for SSE (Requires the AWS managed CMK for global tables: alias/aws/dynamodb)"
  type        = string
  default     = null
}

variable "stream_enabled" {
  description = "Enables DynamoDB Streams if set to true"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "The type of objects to stream if streams are enabled"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string, string)
  default     = {}
}

variable "ttl_attribute_name" {
  description = "The name of the attribute to store the TTL timestamp for items"
  type        = string
  default     = null
}

variable "ttl_enabled" {
  description = "Enable TTL on table items (warning: Probably don't enable this)"
  type        = bool
  default     = null
}

variable "write_capacity" {
  description = "Number of write capacity units to provision for the tables"
  type        = number
  default     = 1
}
