locals {
  aws_region            = data.terraform_remote_state.part1.outputs.aws_region
  account_id            = data.terraform_remote_state.part1.outputs.account_id
  role_name             = data.terraform_remote_state.part1.outputs.role_name
  s3_bucket_name        = data.terraform_remote_state.part1.outputs.s3_bucket_name
  user_name             = data.terraform_remote_state.part1.outputs.user_name
  pcr8_value            = data.terraform_remote_state.part1.outputs.pcr8_value
  kms_key_id            = data.terraform_remote_state.part1.outputs.kms_key_id
}

variable "iam_cmk_inline_policy" {
  description = "The IAM KMS CMK inline policy"
}

variable "ec2_instance_name" {
  description = "The name of the EC2 instance"
}

variable "ec2_instance_type" {
  description = "The type of EC2 instance"
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
