output "instance_ip" {
  value = aws_instance.nitro-mainnet-01.private_ip
}

output "kms_id_01" {
  value = aws_kms_key.nitro-mainnet-01-kms.id
}

output "ami_id" {
  description = "The AMI ID used for the EC2 instance"
  value       = aws_instance.nitro-mainnet-01.ami
}

output "ami_name" {
  description = "The name of the AMI used for the EC2 instance"
  value       = data.aws_ami.amazon_linux_2023.name
}

output "iam_role_name" {
  description = "The name of the IAM role created"
  value       = aws_iam_role.nitro_mainnet_ec2_role.name
}

output "iam_instance_profile_name" {
  description = "The name of the IAM instance profile created"
  value       = aws_iam_instance_profile.nitro_mainnet_ec2_role_profile.name
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket created"
  value       = aws_s3_bucket.nitro_mainnet_bucket.id
}
