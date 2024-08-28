# create IAM inline policy 
resource "aws_iam_role_policy" "inline_policy" {
  name = var.iam_cmk_inline_policy
  role = data.terraform_remote_state.part1.outputs.ec2_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ListBuckets"
        Effect = "Allow"
        Action = "s3:ListAllMyBuckets"
        Resource = "*"
      },
      {
        Sid    = "WritePermissionsOnBucket"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::${data.terraform_remote_state.part1.outputs.s3_bucket_name}/*"
      },
      {
        Sid    = "AccessToTheKey"
        Effect = "Allow"
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyPair",
          "kms:GenerateDataKeyWithoutPlaintext",
          "kms:GenerateDataKeyPairWithoutPlaintext",
          "kms:GenerateRandom",
          "kms:GetKeyPolicy"
        ]
        Resource = "arn:aws:kms:${local.aws_region}:${local.account_id}:key/${local.kms_key_id}"
      }
    ]
  })
}

# attach policy
resource "aws_iam_role_policy_attachment" "ssm_core_policy" {
  role       = data.terraform_remote_state.part1.outputs.ec2_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}