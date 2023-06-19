resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "name" {
  description = "Name tag for the internet gateway"
}

output "igw_id" {
  value = aws_internet_gateway.main.id
}