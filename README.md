# aws-terraform-fireblocks-cosigner

Part1:
- define IAM role & policy
- create S3 bucket & policy
- create KMS key & policy

Part2:
- create EC2 instance
- create IAM role & policy
- create security group

## Configuration Requirements

Before using this Terraform configuration, please ensure the following variables are set:

1. Copy `terraform.tfvars.example` to `terraform.tfvars`
2. Set the following variables in `terraform.tfvars`:
   - `vpc_id`: Your VPC ID
   - `subnet_id`: Your Subnet ID
