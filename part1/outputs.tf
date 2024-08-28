output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}

output "aws_region" {
  value       = var.aws_region
  description = "The AWS region where resources are deployed"
}

output "s3_bucket_name" {
  value       = var.s3_bucket_name
  description = "The name of the S3 bucket"
}

output "ec2_ami" {
  value       = var.ec2_ami
  description = "The AMI ID for the EC2 instance"
}

output "account_id" {
  value       = var.account_id
  description = "The AWS account ID"
}

output "role_name" {
  value       = var.role_name
  description = "The name of the IAM role"
}

output "user_name" {
  value       = var.user_name
  description = "The name of the IAM user"
}

output "kms_alias" {
  value       = var.kms_alias
  description = "The alias for the KMS key"
}

output "kms_key_id" {
  value       = var.kms_key_id
  description = "The existing CMS key ID"
}

output "pcr8_value" {
  value       = var.pcr8_value
  description = "The PCR8 value for attestation"
}
