output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.nitro_instance.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = data.terraform_remote_state.part1.outputs.s3_bucket_arn
}

output "ec2_role_arn" {
  description = "The ARN of the EC2 role"
  value       = data.terraform_remote_state.part1.outputs.ec2_role_arn
}
