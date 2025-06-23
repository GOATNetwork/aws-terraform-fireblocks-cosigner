output "instance_ip" {
  value = aws_instance.nitro-mainnet-01.private_ip
}

output "kms_id_01" {
  value = aws_kms_key.nitro-mainnet-01-kms.id
}
