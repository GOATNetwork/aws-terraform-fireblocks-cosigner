resource "aws_eip" "rpc-goat-eip" {
    domain = "vpc"
    instance = aws_instance.rpc-goat.id
    tags = {
        Name = "rpc-goat-eip"
    }
    tags_all = {
        Name = "rpc-goat-eip"
    }
}

resource "aws_eip_association" "rpc-goat-eip-assoc" {
    allocation_id = aws_eip.rpc-goat-eip.id
    instance_id = aws_instance.rpc-goat.id
}
