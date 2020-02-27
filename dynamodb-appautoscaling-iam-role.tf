data "aws_iam_policy_document" "tf_state_dynamodb_appautoscaling_role_trust" {
  statement {
    sid = "AllowTheDynamoDBApplicationAutoscalingServiceAssumeTheRole"

    principals {
      type        = "Service"
      identifiers = ["dynamodb.application-autoscaling.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "tf_state_dynamodb_appautoscaling" {
  name               = "tf-state-dynamodb-appautoscaling"
  assume_role_policy = data.tf_state_dynamodb_appautoscaling_role_trust.json
  path               = "/service/aws/application-autoscaling/dynamodb/"
  tags               = var.tags

  description = <<-EOT
      Service-linked role to allow Application Autoscaling to manage Target
      Tracking scaling for the DynamoDB tables used for Terraform state locking
      operations.
    EOT
}

data "aws_iam_policy_document" "tf_state_dynamodb_appautoscaling_role" {
  # ========================================================================= #
  # Service role for Application Autoscaling to be able to manage Target      #
  # Tracking policies for the TF state lock DynamoDB tables. Permissions are  #
  # more strict than the AWS-managed service-linked role that grants access   #
  # to all DynamoDB tables and CloudWatch alarms.                             #
  # ========================================================================= #

  statement {
    sid = "UpdateDynamoDBScalingProperties"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:UpdateTable",
    ]

    // Only allow access to the TF state lock tagbles
    resources = [
      aws_dynamodb_table.terraform_state_lock_us-east-1.arn,
      aws_dynamodb_table.terraform_state_lock_us-west-2.arn,
    ]

    // Only allow access to tables in specific regions
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"

      values = [
        "us-east-1",
        "us-west-2",
      ]
    }

    // Only allow access if the table(s) are tagged: AllowAppAutoscaling = True
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/AllowAppAutoscaling"
      values   = ["True"]
    }
  }

  statement {
    sid = "TriggerCloudWatchAlarms"

    actions = [
      "cloudwatch:DeleteAlarms",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
    ]

    resources = [
      "arn:aws:cloudwatch:us-east-1:{var.account_id}:alarm:TargetTracking-*-AlarmHigh-*",
      "arn:aws:cloudwatch:us-east-1:{var.account_id}:alarm:TargetTracking-*-AlarmLow-*",
      "arn:aws:cloudwatch:us-west-2:{var.account_id}:alarm:TargetTracking-*-AlarmHigh-*",
      "arn:aws:cloudwatch:us-west-2:{var.account_id}:alarm:TargetTracking-*-AlarmLow-*",
    ]
  }
}

resource "aws_iam_policy" "tf_state_dynamodb_appautoscaling" {
  name   = "tf-state-dynamodb-appautoscaling"
  path   = "/service/aws/dynamodb/application-autoscaling/"
  policy = data.tf_state_dynamodb_appautoscaling_role.json

  description = <<-EOT
      Allow managing Target Tracking scaling for the DynamoDB tables used for
      Terraform state locking operations. Grants access to specific DynamoDB
      tables and CloudWatch alarms (via wildcard).
    EOT
}

resource "aws_iam_policy_attachment" "tf_state_dynamodb_appautoscaling" {
  name       = "ManageDynamoDBTargetTrackingScaling"
  roles      = [aws_iam_role.tf_state_dynamodb_appautoscaling.name]
  policy_arn = aws_iam_policy.tf_state_dynamodb_appautoscaling.arn
}
