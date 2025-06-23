data "aws_ami" "ubuntu-2404-amd64-20240927" {
  owners      = ["099720109477"] # 替换为 AMI 的拥有者 ID
  filter {
    name   = "name" # name = "image-id" AMI ID
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240927"] # 替换为你的 AMI NAME 
  }
}

data "aws_ami" "ubuntu-2204-amd64-20240927" {
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240927"]
  }
}

data "aws_ami" "al2023-20241121-x86_64" {
  owners      = ["137112412989"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.20241121.0-kernel-6.1-x86_64"]
  }
}