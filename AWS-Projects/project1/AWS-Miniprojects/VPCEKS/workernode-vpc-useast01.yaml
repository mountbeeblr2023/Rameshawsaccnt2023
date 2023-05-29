# Create the worker node VPC
resource "aws_vpc" "worker-node-useast01" {
  cidr_block = "10.20.0.0/16"  # Replace with your desired CIDR block
}

# Create the worker node subnets
resource "aws_subnet" "wokernode-sub-1a" {
  vpc_id                  = aws_vpc.worker-node-useast01.id
  cidr_block              = "10.20.0.0/20"  # Replace with your desired CIDR block for subnet1
  availability_zone       = "us-east-1a"   # Replace with your desired availability zone
}

resource "aws_subnet" "workernode-sub-1c" {
  vpc_id                  = aws_vpc.worker-node-useast01.id
  cidr_block              = "10.20.16.0/24"  # Replace with your desired CIDR block for subnet2
  availability_zone       = "us-east-1b"   # Replace with your desired availability zone
}

resource "aws_subnet" "workernode-sub-1c" {
  vpc_id                  = aws_vpc.worker-node-useast01.id
  cidr_block              = "10.20.32.0/24"  # Replace with your desired CIDR block for subnet3
  availability_zone       = "us-east-1c"   # Replace with your desired availability zone
}


# Create a private route table for VPC
resource "aws_route_table" "private_route_table_workernode-vpc-useast01" {
  vpc_id = data.aws_vpc.worker-node-useast01.id

  tags = {
    Name = "PrivateRouteTable_workernode-vpc-useast01"
  }
}

# Associate subnets with the route table
resource "aws_route_table_association" "subnet_association_01" {
  subnet_id      = aws_subnet.workernode-sub-1a.id  # Replace with your subnet ID
  route_table_id = aws_route_table.private_route_table_workernode-vpc-useast01.id
}

resource "aws_route_table_association" "subnet_association_02" {
  subnet_id      = aws_subnet.workernode-sub-1b.id  # Replace with your subnet ID
  route_table_id = aws_route_table.private_route_table_workernode-vpc-useast01.id
}

resource "aws_route_table_association" "subnet_association_03" {
  subnet_id      = aws_subnet.workernode-sub-1c.id  # Replace with your subnet ID
  route_table_id = aws_route_table.private_route_table_workernode-vpc-useast01.id
}


# Associate subnets with the EKS control plane subnet network ACL
resource "aws_network_acl_association" "Nacl_association_01" {
  subnet_id      = aws_subnet.workernode-sub-1a.id  # Replace with your subnet ID
  network_acl_id = aws_network_acl.worker_nodes_nacl01.id
}

resource "aws_network_acl_association" "Nacl_association_02" {
  subnet_id      = aws_subnet.workernode-sub-1b.id  # Replace with your subnet ID
  network_acl_id = aws_network_acl.worker_nodes_nacl01.id
}
resource "aws_network_acl_association" "Nacl_association_02" {
  subnet_id      = aws_subnet.workernode-sub-1c.id  # Replace with your subnet ID
  network_acl_id = aws_network_acl.worker_nodes_nacl01.id
}