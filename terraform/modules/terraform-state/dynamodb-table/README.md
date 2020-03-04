# DynamoDB Global Table (v2) for Terraform State Locks

Manages a DynamoDB Global Table for storing Terraform state locks. 

## Variables

billing_mode
hash_key
hash_key_type
name
point_in_time_recovery_enabled
read_capacity
replica_regions
server_side_encryption_enabled
server_side_encryption_kms_key_arn
stream_enabled
stream_view_type
tags
ttl_attribute_name
ttl_enabled
write_capacity

## Outputs

arn
attribute
billing_mode
global_secondary_index
id
local_secondary_index
name
point_in_time_recovery
range_key
read_capacity
replica
server_side_encryption
stream_enabled
stream_label
stream_view_type
tags
ttl
write_capacity
