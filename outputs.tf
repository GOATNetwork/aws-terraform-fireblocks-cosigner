output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.nitro_instance.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.nitro_dev_02_bucket.arn
}

output "ec2_role_arn" {
  description = "The ARN of the EC2 role"
  value       = aws_iam_role.ec2_role.arn
}
