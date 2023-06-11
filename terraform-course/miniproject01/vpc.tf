########## Create IGW ##########
resource "aws_internet_gateway" "project01-IGW" {
  vpc_id = aws_vpc.project01_vpc.id

  tags = {
    Name = "project01-IGW"
  }
}

######### Create VPC ############
resource "aws_vpc" "project01_vpc" {
  cidr_block = var.blr_vpc
  tags = {
    Name = "project01-vpc"
  }
}

########### Create subnets ##########
resource "aws_subnet" "project01_public_subnet" {
  vpc_id                  = aws_vpc.project01_vpc.id
  cidr_block              = var.blr_public_subnet
  availability_zone       = var.blr_public_az
  tags = {
    Name = "project01_public_subnet-c"
  }
}

resource "aws_subnet" "project01_private_subnet" {
  count                   = length(var.blr_private_subnet)
  vpc_id                  = aws_vpc.project01_vpc.id
  cidr_block              = var.blr_private_subnet[count.index]
  availability_zone       = var.blr_private_az[count.index]
  tags = {
    Name = "project01_private_subnet-${element(["a", "b"], count.index)}"
  }
}

 ######### Associate the IGW to Public Route Table ############
 resource "aws_route_table_association" "project01-IGW_association" {
   route_table_id         = aws_route_table.project01_public_route_table.id
   gateway_id             = aws_internet_gateway.project01-IGW.id
}

####### Create private route table for subnets #######
resource "aws_route_table" "project01_private_route_table" {
  vpc_id = aws_vpc.project01_vpc.id
  tags = {
    Name = "project01_private_route_table"
  }
}

####### Create public route table for subnets ########
resource "aws_route_table" "project01_public_route_table" {
  vpc_id = aws_vpc.project01_vpc.id
  tags = {
    Name = "project01_private_route_table"
  }
}

####### subnet associations with route table ########
resource "aws_route_table_association" "project01_private_route_table_association" {
  count          = length(aws_subnet.project01_private_subnet)
  subnet_id      = aws_subnet.project01_private_subnet[count.index].id
  route_table_id = aws_route_table.project01_private_route_table.id
}

resource "aws_route_table_association" "project01_public_route_table_association" {
  subnet_id      = aws_subnet.project01_public_subnet.id
  route_table_id = aws_route_table.project01_public_route_table.id
}

