variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-2"
}

variable "ami_name_pattern" {
  description = "Pattern to match AMI name for filtering"
  type        = string
  default     = "al2023-ami-*-x86_64"
}

variable "ami_owner" {
  description = "Owner of the AMI"
  type        = string
  default     = "amazon"
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  default     = "590184059249"
}

variable "internal_cidr_blocks" {
  description = "CIDR blocks for internal services (ports 4001, 50051)"
  type        = list(string)
  default     = ["12.0.0.0/16"]
}
