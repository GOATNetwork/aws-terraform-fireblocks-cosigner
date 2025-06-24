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

variable "key_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
  default     = "relayer-prod"
}
