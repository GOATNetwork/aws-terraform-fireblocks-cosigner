variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  default     = "nitro-dev-02-bucket"
}

variable "ec2_ami" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-0ba84480150a07294"
}

variable "account_id" {
  description = "The AWS account ID"
}

variable "role_name" {
  description = "The name of the IAM role"
  default     = "nitro-dev-02-ec2-role"
}

variable "user_name" {
  description = "The name of the IAM user"
}

variable "kms_alias" {
  description = "The alias for the KMS key"
  default     = "fireblocks-nitro-cosigner-02"
}

variable "kms_key_id" {
  description = "The exist CMS key id"
}

variable "pcr8_value" {
  description = "The PCR8 value for attestation"
}

variable "iam_cmk_inline_policy" {
  description = "The IAM KMS CMK inline policy"
  default     = "nitro-dev-02-cms-inline-policy"
}

variable "ec2_instance_name" {
  description = "The name of the EC2 instance"
}

variable "ec2_instance_type" {
  description = "The type of EC2 instance"
  default     = "c5.xlarge"
}

variable "ec2_key_name" {
  description = "Pem key pair name to login ec2"
}

variable "subnet_id" {
  description = "The subnet ID where the instance will be launched"
}

variable "vpc_id" {
  description = "The VPC ID where the instance will be launched"
}

variable "allowed_ssh_cidr" {
  description = "The CIDR block that is allowed to SSH into the instance"
}
