# Create Nitro-capable EC2
resource "aws_instance" "nitro-mainnet-01" {
  ami                         = data.terraform_remote_state.shared.outputs.ami_al2023-20241121-x86_64-id # Amazon Linux 2023 AMI 64-bit (x86)
  instance_type               = "c5.xlarge"
  iam_instance_profile        = aws_iam_instance_profile.nitro_mainnet_ec2_role_profile.name
  subnet_id                   = data.terraform_remote_state.self-vpc.outputs.dev-goatnetwork-vpc-subnet-private1-us-east-2a-id
  vpc_security_group_ids      = [aws_security_group.nitro-instance-sg.id]
  key_name                    = "stephen-relayer-prod"
  depends_on = [
    aws_security_group.nitro-instance-sg
  ]
  enclave_options {
    enabled = true
  }

  root_block_device {
      volume_size = 100
      volume_type = "gp3"
      delete_on_termination = true
  }
  metadata_options {
    http_tokens               = "required"
    http_put_response_hop_limit = 2
    http_endpoint             = "enabled"
  }

  tags = {
    Name = "nitro-mainnet-01"
  }
}

# create IAM Instance Profile
resource "aws_iam_instance_profile" "nitro_mainnet_ec2_role_profile" {
  name = "nitro-mainnet-ec2-role-profile"
  role = aws_iam_role.nitro_mainnet_ec2_role.name
}