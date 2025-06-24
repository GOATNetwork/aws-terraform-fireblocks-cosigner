resource "aws_security_group" "relayer-server-mainnet-sg" {
    description = "Security group for relayer server"
    name = "relayer-server-mainnet-sg"
    tags = {
        Name = "relayer-server-mainnet-sg"
    }
    vpc_id = var.vpc_id
    ingress {
        cidr_blocks = var.internal_cidr_blocks
        from_port = 8080
        protocol = "tcp"
        to_port = 8080
    }
    ingress {
        cidr_blocks = var.internal_cidr_blocks
        from_port = 4001
        protocol = "tcp"
        to_port = 4001
    }
    ingress {
        cidr_blocks = var.internal_cidr_blocks
        from_port = 9009
        protocol = "tcp"
        to_port = 9009
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}
