output "instance_ip_goat" {
  value = aws_eip.rpc-goat-eip.public_ip
}
