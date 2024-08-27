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

# create a S3 bucket
resource "aws_s3_bucket" "nitro_dev_02_bucket" {
  bucket = var.s3_bucket_name
}

# create s3 policy
resource "aws_s3_bucket_policy" "nitro_dev_02_bucket_policy" {
  bucket = aws_s3_bucket.nitro_dev_02_bucket.id
  policy = data.aws_iam_policy_document.nitro_dev_02_bucket_policy.json
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

### Due to the KMS issue, the following snippet should apply as new project and ${var.kms_key_id}

# find IAM role
resource "aws_iam_role" "ec2_role" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# attach policy
resource "aws_iam_role_policy_attachment" "ssm_core_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# create IAM inline policy 
resource "aws_iam_role_policy" "inline_policy" {
  name   = var.iam_cmk_inline_policy
  role   = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "ListBuckets",
        Effect = "Allow",
        Action = "s3:ListAllMyBuckets",
        Resource = "*"
      },
      {
        Sid = "WritePermissionsOnBucket",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      },
      {
        Sid = "AccessToTheKey",
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyPair",
          "kms:GenerateDataKeyWithoutPlaintext",
          "kms:GenerateDataKeyPairWithoutPlaintext",
          "kms:GenerateRandom",
          "kms:GetKeyPolicy"
        ],
        Resource = "arn:aws:kms:${var.aws_region}:${var.account_id}:key/${var.kms_key_id}" # ${aws_kms_key.cmk.id}
      }
    ]
  })
}

# create security group
resource "aws_security_group" "ec2_sg" {
  name        = "nitro-instance-sg"
  description = "Security group for Nitro-capable EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Nitro-capable EC2
resource "aws_instance" "nitro_instance" {
  ami                         = "ami-02d3770deb1c746ec" # Amazon Linux 2023 AMI 64-bit (x86)
  instance_type               = var.ec2_instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_role_profile.name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = var.ec2_key_name
  enclave_options {
    enabled = true
  }

  metadata_options {
    http_tokens               = "required"
    http_put_response_hop_limit = 2
    http_endpoint             = "enabled"
  }

  tags = {
    Name = var.ec2_instance_name
  }
}

# create IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_role_profile" {
  name = "ec2_role_profile"
  role = aws_iam_role.ec2_role.name
}
