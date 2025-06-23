resource "aws_subnet" "goatnetwork-vpc-subnet-public1-us-east-2a" {
    availability_zone = "us-east-2a"
    cidr_block = "12.0.0.0/20"
    vpc_id = aws_vpc.goatnetwork-vpc.id
    map_public_ip_on_launch = false
    tags = {
        Name = "goatnetwork-vpc-subnet-public1-us-east-2a"
    }
    tags_all = {
        Name = "goatnetwork-vpc-subnet-public1-us-east-2a"
    }
}

resource "aws_subnet" "goatnetwork-vpc-subnet-public2-us-east-2b" {
    availability_zone = "us-east-2b"
    cidr_block = "12.0.16.0/20"
    vpc_id = aws_vpc.goatnetwork-vpc.id
    map_public_ip_on_launch = false
    tags = {
        Name = "goatnetwork-vpc-subnet-public2-us-east-2b"
    }
    tags_all = {
        Name = "goatnetwork-vpc-subnet-public2-us-east-2b"
    }
}

resource "aws_subnet" "goatnetwork-vpc-subnet-public3-us-east-2c" {
    availability_zone = "us-east-2c"
    cidr_block = "12.0.32.0/20"
    vpc_id = aws_vpc.goatnetwork-vpc.id
    map_public_ip_on_launch = false
    tags = {
        Name = "goatnetwork-vpc-subnet-public3-us-east-2c"
    }
    tags_all = {
        Name = "goatnetwork-vpc-subnet-public3-us-east-2c"
    }
}


resource "aws_subnet" "goatnetwork-vpc-subnet-private1-us-east-2a" {
    availability_zone = "us-east-2a"
    cidr_block = "12.0.128.0/20"
    vpc_id = aws_vpc.goatnetwork-vpc.id
    map_public_ip_on_launch = false
    tags = {
        Name = "goatnetwork-vpc-subnet-private1-us-east-2a"
    }
    tags_all = {
        Name = "goatnetwork-vpc-subnet-private1-us-east-2a"
    }
}

resource "aws_subnet" "goatnetwork-vpc-subnet-private2-us-east-2b" {
    availability_zone = "us-east-2b"
    cidr_block = "12.0.144.0/20"
    vpc_id = aws_vpc.goatnetwork-vpc.id
    map_public_ip_on_launch = false
    tags = {
        Name = "goatnetwork-vpc-subnet-private2-us-east-2b"
    }
    tags_all = {
        Name = "goatnetwork-vpc-subnet-private2-us-east-2b"
    }
}

resource "aws_subnet" "goatnetwork-vpc-subnet-private3-us-east-2c" {
    availability_zone = "us-east-2c"
    cidr_block = "12.0.160.0/20"
    vpc_id = aws_vpc.goatnetwork-vpc.id
    map_public_ip_on_launch = false
    tags = {
        Name = "goatnetwork-vpc-subnet-private3-us-east-2c"
    }
    tags_all = {
        Name = "goatnetwork-vpc-subnet-private3-us-east-2c"
    }
}

