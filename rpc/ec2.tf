data "aws_ami" "ubuntu_2204" {
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

resource "aws_instance" "rpc-goat" {
    ami = data.aws_ami.ubuntu_2204.id
    instance_type = "c5.2xlarge"
    key_name = var.key_name
    tenancy = "default"
    subnet_id = var.subnet_id
    ebs_optimized = false
    vpc_security_group_ids = [
        aws_security_group.rpc-sg.id
    ]
    source_dest_check = true
    root_block_device {
        volume_size = 100
        volume_type = "gp3"
        delete_on_termination = true
    }
    iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
    tags = {
        Name = "rpc-goat"
    }
}
