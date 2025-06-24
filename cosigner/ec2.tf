# Data source to get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Create Nitro-capable EC2
resource "aws_instance" "nitro-mainnet-01" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "c5.xlarge"
  iam_instance_profile        = aws_iam_instance_profile.nitro_mainnet_ec2_role_profile.name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.nitro-instance-sg.id]
  key_name                    = var.key_name
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
  name = "nitro-mainnet-ec2-role-profile-${random_id.resource_suffix.hex}"
  role = aws_iam_role.nitro_mainnet_ec2_role.name
}
