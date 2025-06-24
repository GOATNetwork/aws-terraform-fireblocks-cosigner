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
