locals {
  targets = {
    read_capacity = {
      min_capacity       = var.read_capacity_min
      max_capacity       = var.read_capacity_max
      scalable_dimension = "ReadCapacityUnits"
    }

    write_capacity = {
      min_capacity       = var.write_capacity_min
      max_capacity       = var.write_capacity_max
      scalable_dimension = "WriteCapacityUnits"
    }
  }

  policies = {
    read_capacity = {
			predefined_metric_type = "DynamoDBReadCapacityUtilization"
			target_value = var.read_target_value
    }

    write_capacity = {
			predefined_metric_type = "DynamoDBWriteCapacityUtilization"
			target_value = write_target_value
    }
  }
}

resource "aws_appautoscaling_target" "main" {
  for_each = local.appautoscaling_targets
 
  min_capacity       = each.value["min_capacity"]
  max_capacity       = each.value["max_capacity"]
  resource_id        = "table/${var.table_name}"
  role_arn           = var.role_arn
  scalable_dimension = "dynamodb:table:${each.value["scalable_dimension"]}"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "main" {
	for_each = local.policies

  name               = "${each.value["predefined_metric_type"]}:${aws_appautoscaling_target.main[each.key].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.main[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.main[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.main[each.key].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = each.value["predefined_metric_type"]
    }

    target_value = each.value["target_value"]
  }
}

output "targets" {
  description = "List of AppAutoscaling target resources"
  value       = aws_appautoscaling_target.main
}

output "policies" {
  description = "List of AppAutoscaling policy resources"
  value       = aws_appautoscaling_policy.main
}
