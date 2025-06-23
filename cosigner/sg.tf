resource "aws_security_group" "nitro-instance-sg" {
  name        = "nitro-instance-sg"
  description = "Security group for Nitro-capable EC2 instance"
  vpc_id      = var.vpc_id
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8080
    to_port   = 8080  
    protocol  = "tcp"
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 4001
    to_port   = 4001
    protocol  = "tcp"
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 50051
    to_port   = 50051
    protocol  = "tcp"
  }
  egress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}
