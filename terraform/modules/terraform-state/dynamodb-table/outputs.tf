output "arn" {
  description = "The arn of the table"
  value       = aws_dynamodb_table.main.arn
}

output "attribute" {
  description = "List of nested attribute definitions"
  vale        = aws_dynamodb_table.main.attribute
}

output "billing_mode" {
  description = "Mode for billing: throughput and capacity (PROVISIONED | PAY_PER_REQUEST)"
  value       = aws_dynamodb_table.main.billing_mode
}

output "global_secondary_index" {
  description = "Describe a GSI on the table"
  value       = aws_dynamodb_table.main.
}

output "id" {
  description = "The name of the table"
  value       = aws_dynamodb_table.main.id
}

output "local_secondary_index" {
  description = "Describe an LSI on the table"
  value       = aws_dynamodb_table.main.local_secondary_index
}

output "name" {
  description = "The name of the table"
  value       = aws_dynamodb_table.main.name
}

output "point_in_time_recovery" {
  description = "Whether to enable point-in-time recovery"
  value       = aws_dynamodb_table.main.point_in_time_recovery
}

output "range_key" {
  description = "The attribute to use as the sort key"
  value       = aws_dynamodb_table.main.range_key
}

output "read_capacity" {
  description = "The number of provisioned read units for the table"
  value       = aws_dynamodb_table.main.read_capacity
}

output "replica" {
  description = "Global Table v2 replication settings"
  value       = aws_dynamodb_table.main.replica
}

output "server_side_encryption" {
  description = "Encryption at rest options"
  value       = aws_dynamodb_table.main.server_side_encryption
}

output "stream_arn" {
  description = "The ARN of the table stream"
  value       = aws_dynamodb_table.main.stream_arn
}

output "stream_enabled" {
  description = "Whether or not to enable streams (default: false)"
  value       = aws_dynamodb_table.main.stream_enabled
}

output "stream_label" {
  description = "A timestamp, in ISO 8601 format, for the stream"
  value       = aws_dynamodb_table.main.stream_label
}

output "stream_view_type" {
  description = "Determines which information is written to the stream ("
  value       = aws_dynamodb_table.main.stream_view_type
}

output "tags" {
  description = "A map of tags applied to the table"
  value       = aws_dynamodb_table.main.tags
}

output "ttl" {
  description = "Defines TTL settings for table objects"
  value       = aws_dynamodb_table.main.ttl
}

output "write_capacity" {
  description = "The number of provisioned write capacity units for the table"
  value       = aws_dynamodb_table.main.write_capacity
}
