resource "aws_security_group" "rpc-sg" {
    name = "rpc-sg"
    tags = {
        Name = "rpc-sg"
    }
    vpc_id = var.vpc_id
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        description = "geth P2P Port (UDP) "
        from_port = 30303
        protocol = "udp"
        to_port = 30303
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        description = "geth P2P Port (TCP)"
        from_port = 30303
        protocol = "tcp"
        to_port = 30303
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        description = "consensus P2P Port"
        from_port = 26656
        protocol = "tcp"
        to_port = 26656
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
