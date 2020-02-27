variable "account_id" {
  description = "AWS account ID to operate on"
  type        = number
}

variable "regions" {
  description = "List of AWS regions to create resources in"
  type        = set(string)
  default     = ["us-east-1", "us-west-2"]
}
