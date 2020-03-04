# resource "aws_cloudtrail" "iam_read" {
#   // Trail for IAM read events
#   name                          = "iam-read"
#   s3_bucket_name                =
#   s3_key_prefix                 =
#   cloudwatch_logs_role_arn      =
#   cloudwatch_logs_group_arn     =
#   enable_logging                =
#   include_global_service_events = true
#   is_multi_region_trail         = true
#   is_organization_trail         = false
#   sns_topic_name                =
#   enable_log_file_validation    = true
#   kms_key_id                    =
#   event_selector                =
#   tags                          =
#
#   event_selector {
#     read_write_type           = "ReadOnly"
#     include_management_events =
#     data_resource             =
#
#     data_resource {
#       type   =
#       values =
#     }
#   }
# }
#
# resource "aws_cloudtrail" "iam_write" {
#   // Trail for IAM write events
#   name                          = "iam-write"
#   s3_bucket_name                =
#   s3_key_prefix                 =
#   cloudwatch_logs_role_arn      =
#   cloudwatch_logs_group_arn     =
#   enable_logging                =
#   include_global_service_events = true
#   is_multi_region_trail         = true
#   is_organization_trail         = false
#   sns_topic_name                =
#   enable_log_file_validation    = true
#   kms_key_id                    =
#   tags                          =
#
#   event_selector {
#     read_write_type           = "WriteOnly"
#     include_management_events =
#     data_resource             =
#
#     data_resource {
#       type   =
#       values =
#     }
#   }
# }
#
# resource "aws_cloudtrail" "iam_write" {
#   // Trail for IAM write events
#   name                          =
#   s3_bucket_name                =
#   s3_key_prefix                 =
#   cloudwatch_logs_role_arn      =
#   cloudwatch_logs_group_arn     =
#   enable_logging                =
#   include_global_service_events =
#   is_multi_region_trail         =
#   is_organization_trail         =
#   sns_topic_name                =
#   enable_log_file_validation    =
#   kms_key_id                    =
#   event_selector                =
#   tags                          =
# }
#
# resource "aws_cloudtrail" "iam_write" {
#   // Trail for IAM write events
#   name                          =
#   s3_bucket_name                =
#   s3_key_prefix                 =
#   cloudwatch_logs_role_arn      =
#   cloudwatch_logs_group_arn     =
#   enable_logging                =
#   include_global_service_events =
#   is_multi_region_trail         =
#   is_organization_trail         =
#   sns_topic_name                =
#   enable_log_file_validation    =
#   kms_key_id                    =
#   event_selector                =
#   tags                          =
# }
