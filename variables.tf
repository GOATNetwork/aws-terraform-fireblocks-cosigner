variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  default     = "nitro-dev-bucket-02"
}

variable "ec2_ami" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-02d3770deb1c746ec"
}

variable "account_id" {
  description = "The AWS account ID"
  default     = "590184059249"
}

variable "role_name" {
  description = "The name of the IAM role"
  default     = "nitro-dev-02-ec2-role"
}

variable "user_name" {
  description = "The name of the IAM user"
  default     = "aiden"
}

variable "kms_alias" {
  description = "The alias for the KMS key"
  default     = "fireblocks-nitro-cosigner-02-A"
}

variable "kms_key_id" {
  description = "The exist CMS key id"
  default = "0e28fd63-f8ec-4edf-9ea7-a86dd5af1c9e"
}

variable "pcr8_value" {
  description = "The PCR8 value for attestation"
  default = "da1d9eca20ce98ab4fdbc51f8e5a2307fd4c61829b7d8bff40976cd6676862c8f3476ff4bdd0f65ecf4a48d6eb3099a8"
}

variable "iam_cmk_inline_policy" {
  description = "The IAM KMS CMK inline policy"
  default     = "nitro-dev-02-cms-inline-policy"
}

variable "ec2_instance_name" {
  description = "The name of the EC2 instance"
  default     = "nitro-dev-02-instance"
}

variable "ec2_instance_type" {
  description = "The type of EC2 instance"
  default     = "c5.xlarge"
}

variable "ec2_key_name" {
  description = "Pem key pair name to login ec2"
  default     = "aiden-nitro"
}

variable "subnet_id" {
  description = "The subnet ID where the instance will be launched"
  default     = "subnet-09202e27c8fc7a3e5"
}

variable "vpc_id" {
  description = "The VPC ID where the instance will be launched"
  default     = "vpc-092a7a0402a963c90"
}

variable "allowed_ssh_cidr" {
  description = "The CIDR block that is allowed to SSH into the instance"
  default     = "113.218.146.142/32"
}
