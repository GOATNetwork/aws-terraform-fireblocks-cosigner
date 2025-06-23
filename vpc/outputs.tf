output "dev-goatnetwork-vpc-id" {
  value       = aws_vpc.goatnetwork-vpc.id
  description = "goatnetwork-vpc id"
}

output "dev-goatnetwork-vpc-subnet-public1-us-east-2a-id" {
  value       = aws_subnet.goatnetwork-vpc-subnet-public1-us-east-2a.id
  description = "goatnetwork-vpc-subnet-public1-us-east-2a id"
}

output "dev-goatnetwork-vpc-subnet-public2-us-east-2b-id" {
  value       = aws_subnet.goatnetwork-vpc-subnet-public2-us-east-2b.id
  description = "goatnetwork-vpc-subnet-public2-us-east-2b id"
}

output "dev-goatnetwork-vpc-subnet-public3-us-east-2c-id" {
  value       = aws_subnet.goatnetwork-vpc-subnet-public3-us-east-2c.id
  description = "goatnetwork-vpc-subnet-public3-us-east-2c id"
}

output "dev-goatnetwork-vpc-subnet-private1-us-east-2a-id" {
  value       = aws_subnet.goatnetwork-vpc-subnet-private1-us-east-2a.id
  description = "goatnetwork-vpc-subnet-private1-us-east-2a id"
}

output "dev-goatnetwork-vpc-subnet-private2-us-east-2b-id" {
  value       = aws_subnet.goatnetwork-vpc-subnet-private2-us-east-2b.id
  description = "goatnetwork-vpc-subnet-private2-us-east-2b id"
}

output "dev-goatnetwork-vpc-subnet-private3-us-east-2c-id" {
  value       = aws_subnet.goatnetwork-vpc-subnet-private3-us-east-2c.id
  description = "goatnetwork-vpc-subnet-private3-us-east-2c id"
}

