# Create worker node VPC
resource "aws_vpc" "worker_vpc" {
  cidr_block = "10.17.0.0/24"
  tags = {
    Name = "worker-vpc"
  }
}

# Create worker node subnets
resource "aws_subnet" "worker_subnet_a" {
  vpc_id                  = aws_vpc.worker_vpc.id
  cidr_block              = "10.17.0.0/28"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "worker-subnet-a"
  }
}

resource "aws_subnet" "worker_subnet_b" {
  vpc_id                  = aws_vpc.worker_vpc.id
  cidr_block              = "10.17.0.16/28"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "worker-subnet-b"
  }
}

# Create security group for worker nodes
resource "aws_security_group" "worker-security-group" {
  vpc_id      = aws_vpc.worker_vpc.id
  name        = "worker-security-group"
  description = "Security group for worker nodes"

  # Ingress rules
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "worker-security-group"
  }
}

# Create network ACL for worker node subnets
resource "aws_network_acl" "worker_nacl" {
  vpc_id = aws_vpc.worker_vpc.id
  subnet_ids = [aws_subnet.worker_subnet_a.id, aws_subnet.worker_subnet_b.id]
  tags = {
    Name = "worker-nacl"
  }
}

# Create route table for worker node subnets
resource "aws_route_table" "worker_route_table" {
  vpc_id = aws_vpc.worker_vpc.id
  tags = {
    Name = "worker-route-table"
  }
}

# Create subnet associations with route table and network ACL
resource "aws_route_table_association" "worker_route_table_association_a" {
  subnet_id      = aws_subnet.worker_subnet_a.id
  route_table_id = aws_route_table.worker_route_table.id
}

resource "aws_route_table_association" "worker_route_table_association_b" {
  subnet_id      = aws_subnet.worker_subnet_b.id
  route_table_id = aws_route_table.worker_route_table.id
}

resource "aws_network_acl_association" "worker_nacl_association_a" {
  subnet_id      = aws_subnet.worker_subnet_a.id
  network_acl_id = aws_network_acl.worker_nacl.id
}

resource "aws_network_acl_association" "worker_nacl_association_b" {
  subnet_id      = aws_subnet.worker_subnet_b.id
  network_acl_id = aws_network_acl.worker_nacl.id
}

