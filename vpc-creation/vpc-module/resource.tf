resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}

########### subnet resource ############

data "aws_availability_zones" "available" {}

resource "aws_subnet" "private_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = var.vpc_output
  cidr_block              = var.private_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.subnet_name}-private_subnet"
  }
}

