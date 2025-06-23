# create KMS key
resource "aws_kms_key" "nitro-mainnet-01-kms" {
  description = "Customer Managed Key for MPC keyshares"
  key_usage   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled  = true

  policy = data.aws_iam_policy_document.kms_policy.json
}
