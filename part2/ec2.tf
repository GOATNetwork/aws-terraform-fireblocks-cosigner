# Create Nitro-capable EC2
resource "aws_instance" "nitro_instance" {
  ami                         = "ami-02d3770deb1c746ec" # Amazon Linux 2023 AMI 64-bit (x86)
  instance_type               = var.ec2_instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_role_profile.name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = var.ec2_key_name
  enclave_options {
    enabled = true
  }

  metadata_options {
    http_tokens               = "required"
    http_put_response_hop_limit = 2
    http_endpoint             = "enabled"
  }

  tags = {
    Name = var.ec2_instance_name
  }
}

# create IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_role_profile" {
  name = "ec2_role_profile"
  role = data.terraform_remote_state.part1.outputs.ec2_role_name
}