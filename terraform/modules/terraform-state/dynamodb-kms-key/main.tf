# NOTE: This can't be used until DynamoDB Global Tables support customer managed CMKs,
# so we have to use the AWS managed key (aws/dynamodb).
#
#

resource "aws_kms_key" "main" {
  description              = var.description
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.main.json
  deletion_window_in_days  = var.deletion_window_in_days
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  tags                     = var.tags
}

data "aws_iam_policy_document" "main" {
  // KMS key policy document: permits usage of the key with DynamoDB
  statement {
    sid    = "Allow root full access to manage the KMS key"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:root"]
    }

    actions   = ["kms:*"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = var.regions
    }
  }

  statement {
    sid    = "Allow alias creation during setup"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["kms:CreateAlias"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = ["${var.account_id}"]
    }
  }

  statement {
    sid    = "Allow principals to create grants through DynamoDB"
    effect = "Allow"

    principal {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["kms:CreateGrant"]
      # kms:ViaService, kms:CallerAccount, kms:GrantConstraintType, kms:GrantIsForAWSResource

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["dynamodb.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = ["${var.account_id}"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:GrantConstraintType"
      values   = ["EncryptionContextEquals"]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }

  statement {
    sid    = "Allow DynamoDB to encrypt and descrypt for principals"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["dynamodb.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = ["${var.account_id}"]
    }

    condition {
      test     = ""
      variable = "kms:EncryptionAlgorithm"
      values   = [""]
    }

    condition {
      test     = ""
      variable = "kms:EncryptionContextKeys"
      values   = [""]
    }

    condition {
      test     = ""
      variable = ""
      values   = [""]
    }
  }

      # kms:ViaService, kms:CallerAccount
      "kms:DescribeKey",

      # kms:ViaService, kms:CallerAccount, kms:EncryptionAlgorithm, kms:EncryptionContextKeys, kms:ReEncryptOnSameKey
      "kms:ReEncryptFrom",
      "kms:ReEncryptTo",

      # kms:ViaService, kms:CallerAccount, kms:EncryptionAlgorithm, kms:EncryptionContextKeys
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",

    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = ["${var.account_id}"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = formatlist("dynamodb.%s.amazonaws.com", var.regions)
    }
  }

  statement {
    sid    = "Allow access through DynamoDB for authorized principals"
    effect = "Allow"

    principal {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [

      # kms:ViaService, kms:CallerAccount
      "kms:DescribeKey",

      # kms:ViaService, kms:CallerAccount, kms:EncryptionAlgorithm, kms:EncryptionContextKeys, kms:ReEncryptOnSameKey
      "kms:ReEncryptFrom",
      "kms:ReEncryptTo",

    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = ["${var.account_id}"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = formatlist("dynamodb.%s.amazonaws.com", var.regions)
    }
  }

  statement {
    sid    = "Allow the DynamoDB service to describe the key"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["dynamodb.amazonaws.com"]
    }

    actions = [
      "kms:ListAliases",
      "kms:ListKeys",
      "kms:ListRetirableGrants",
      
      # kms:ViaService, kms:CallerAccount
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:ListKeyPolicies",
      "kms:ListResourceTags",

      # kms:ViaService, kms:CallerAccount, kms:GrantIsForAWSResource
      "kms:ListGrants",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "Allow this account to access key metadata"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:root"]
    }

    actions = [
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:GetParametersForImport",
      "kms:ListAliases",
      "kms:ListGrants",
      "kms:ListKeyPolicies",
      "kms:ListKeys",
      "kms:ListResourceTags",
      "kms:ListRetirableGrants",
      "kms:RevokeGrant",
    ]

    resources = ["*"]
  }
}
