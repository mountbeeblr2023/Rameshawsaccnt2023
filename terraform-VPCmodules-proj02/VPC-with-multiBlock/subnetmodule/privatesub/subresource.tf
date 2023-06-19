resource "aws_subnet" "private_subnet" {
  count             = length(var.subnet_configs)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_configs[count.index].cidr_block
  availability_zone = var.subnet_configs[count.index].availability_zone
  tags = {
    Name = var.subnet_configs[count.index].name
  }
}




