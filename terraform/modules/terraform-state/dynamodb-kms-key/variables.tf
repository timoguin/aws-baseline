variable "account_id" {
  description = "The AWS account ID"
  type        = number
}

variable "regions" {
  description = "Regions where the key can be used"
  type        = set(string)
  default     = ["us-east-1"]
}

variable "name" {
  description = "The name of the key"
  type        = string
}

variable "alias" {
  description = "The alias for the key"
  default     = null
}

variable "description" {
  description = "The description of the key"
  type        = string
  default     = "Used for DynamoDB table encryption"
}

variable "deletion_window_in_days" {
  description = "The number of days KMS will wait to delete a key after requested"
  type        = number
  default     = null
}

variable "is_enabled" {
  description = "Enable or disable the key (default: true)"
  type        = bool
  default     = null
}

variable "enable_key_rotation" {
  description = "Enable or disable key rotation"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of tags to apply to the key"
  type        = map(string)
  default     = {}
}
