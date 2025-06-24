terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

# Random ID for unique resource names
resource "random_id" "resource_suffix" {
  byte_length = 4
}
