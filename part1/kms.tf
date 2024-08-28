
# create KMS key
resource "aws_kms_key" "cmk" {
  description = "Customer Managed Key for MPC keyshares"
  key_usage   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled  = true

  policy = data.aws_iam_policy_document.kms_policy.json
}

# ?? It run failed here, but it creates successfully without alias
# # create KMS alias 
# resource "aws_kms_alias" "cmk_alias" {
#   name          = "alias/${var.kms_alias}"
#   target_key_id = aws_kms_key.cmk.id
# }

# define KMS policy document
data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid       = "Enable enclave data processing for specific role"
    effect    = "Allow"
    actions   = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyPair",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:GenerateDataKeyPairWithoutPlaintext",
      "kms:GenerateRandom",
      "kms:GetKeyPolicy"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${var.account_id}:role/${var.role_name}"
      ]
    }
    condition {
      test     = "StringEqualsIgnoreCase"
      variable = "kms:RecipientAttestation:PCR8"
      values   = [var.pcr8_value]
    }
  }

  statement {
    sid       = "Allow GetKeyPolicy to co-signer"
    effect    = "Allow"
    actions   = ["kms:GetKeyPolicy"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${var.account_id}:role/${var.role_name}"
      ]
    }
  }

  statement {
    sid       = "Allow policy management to root user"
    effect    = "Allow"
    actions   = [
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:PutKeyPolicy",
      "kms:CreateAlias"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${var.account_id}:root"
      ]
    }
  }
}
