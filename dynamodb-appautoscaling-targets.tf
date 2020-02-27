resource "aws_appautoscaling_target" "dynamodb_tf_state_read_target_us-east-1" {
  max_capacity       = 1
  min_capacity       = 1
  resource_id        = "table/{aws_dynamodb_table.terraform_state_lock_us-east-1}"
  role_arn           = aws_iam_role.tf_state_dynamodb_appautoscaling.arn
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_target" "dynamodb_tf_state_write_target_us-east-1" {
  max_capacity       = 1
  min_capacity       = 1
  resource_id        = "table/{aws_dynamodb_table.terraform_state_lock_us-east-1}"
  role_arn           = aws_iam_role.tf_state_dynamodb_appautoscaling.arn
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_target" "dynamodb_tf_state_read_target_us-west-2" {
  max_capacity       = 1
  min_capacity       = 1
  resource_id        = "table/{aws_dynamodb_table.terraform_state_lock_us-west-2}"
  role_arn           = aws_iam_role.tf_state_dynamodb_appautoscaling.arn
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_target" "dynamodb_tf_state_write_target_us-west-2" {
  max_capacity       = 1
  min_capacity       = 1
  resource_id        = "table/{aws_dynamodb_table.terraform_state_lock_us-west-2}"
  role_arn           = aws_iam_role.tf_state_dynamodb_appautoscaling.arn
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}
