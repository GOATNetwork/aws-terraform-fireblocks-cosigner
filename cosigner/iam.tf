# create an IAM role
resource "aws_iam_role" "nitro_mainnet_ec2_role" {
  name = "nitro-mainnet-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# IAM document
data "aws_iam_policy_document" "nitro_mainnet_bucket_policy" {
  statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:AbortMultipartUpload",
      "s3:GetObjectAcl",
      "s3:PutObjectAcl",
      "s3:RestoreObject"
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.nitro_mainnet_bucket.id}",
      "arn:aws:s3:::${aws_s3_bucket.nitro_mainnet_bucket.id}/*",
    ]

    condition {
      test     = "ArnNotEquals"
      variable = "aws:PrincipalArn"

      values = [
        "arn:aws:iam::${var.aws_account_id}:role/${aws_iam_role.nitro_mainnet_ec2_role.name}",
      ]
    }
  }
}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

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
        "arn:aws:iam::${var.aws_account_id}:role/${aws_iam_role.nitro_mainnet_ec2_role.name}"
      ]
    }
    condition {
      test     = "StringEqualsIgnoreCase"
      variable = "kms:RecipientAttestation:PCR8"
      values   = ["da1d9eca20ce98ab4fdbc51f8e5a2307fd4c61829b7d8bff40976cd6676862c8f3476ff4bdd0f65ecf4a48d6eb3099a8"]
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
        "arn:aws:iam::${var.aws_account_id}:role/${aws_iam_role.nitro_mainnet_ec2_role.name}"
      ]
    }
  }
}

resource "aws_iam_role_policy" "inline_policy" {
  name = "inline_policy"
  role = "${aws_iam_role.nitro_mainnet_ec2_role.name}"

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
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = "arn:aws:s3:::${aws_s3_bucket.nitro_mainnet_bucket.id}"
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
        Resource = "arn:aws:s3:::${aws_s3_bucket.nitro_mainnet_bucket.id}/*"
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
        Resource = "arn:aws:kms:${var.aws_region}:${var.aws_account_id}:key/${aws_kms_key.nitro-mainnet-01-kms.id}"
      }
    ]
  })
}

# attach policy
resource "aws_iam_role_policy_attachment" "ssm_core_policy" {
  role       = aws_iam_role.nitro_mainnet_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
