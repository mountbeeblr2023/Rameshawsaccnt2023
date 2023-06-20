######### VPC CIDR Output ###########
output "vpc_output" {
  description = "ID of the created VPC"
  value       = aws_vpc.main_vpc.id
}

######### subnet output #################
output "private_subnet_output" {
  description = "ID of the created subnet"
  value       = aws_subnet.private_subnet.id
}

