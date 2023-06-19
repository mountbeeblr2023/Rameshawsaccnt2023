output "public-subnet_ids" {
  value = aws_subnet.public_subnetes[*].id
}
