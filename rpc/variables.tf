variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-west-2"
}

variable "ami_name_pattern" {
  description = "Pattern to match AMI name for filtering"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "ami_owner" {
  description = "Owner of the AMI"
  type        = string
  default     = "099720109477"
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
  default     = "rpc-prod"
}
