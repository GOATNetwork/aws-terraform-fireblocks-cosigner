variable "vpc_state_path" {
  description = "Path to the VPC terraform state file"
  type        = string
  default     = "../vpc/terraform.tfstate"
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-2"
} 