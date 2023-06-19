resource "aws_subnet" "public_subnet" {
  count             = length(var.subnet_configs)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_configs[count.index].cidr_block
  availability_zone = var.subnet_configs[count.index].availability_zone
  tags = {
    Name = var.subnet_configs[count.index].name
  }
}
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = var.public_route_table_id
}