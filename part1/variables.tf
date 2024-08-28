variable "aws_region" {
  description = "The AWS region to deploy resources"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
}

variable "ec2_ami" {
  description = "The AMI ID for the EC2 instance"
}

variable "account_id" {
  description = "The AWS account ID"
}

variable "role_name" {
  description = "The name of the IAM role"
}

variable "user_name" {
  description = "The name of the IAM user"
}

variable "kms_alias" {
  description = "The alias for the KMS key"
}

variable "kms_key_id" {
  description = "The exist CMS key id"
}

variable "pcr8_value" {
  description = "The PCR8 value for attestation"
}
