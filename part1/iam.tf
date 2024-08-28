provider "aws" {
  region = var.aws_region
}

# create an IAM role
resource "aws_iam_role" "ec2_role" {
  name = var.role_name

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
data "aws_iam_policy_document" "nitro_dev_02_bucket_policy" {
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
      "arn:aws:s3:::${var.s3_bucket_name}",
      "arn:aws:s3:::${var.s3_bucket_name}/*"
    ]

    condition {
      test     = "ArnNotEquals"
      variable = "aws:PrincipalArn"

      values = [
        "arn:aws:iam::${var.account_id}:role/${var.role_name}",
        "arn:aws:iam::${var.account_id}:user/${var.user_name}"
      ]
    }
  }
}
