# Create VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.16.0.0/20"
  tags = {
    Name = "eks-vpc"
  }
}

# Create subnets
resource "aws_subnet" "eks_subnet_a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.16.0.0/20"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "eks-subnet-a"
  }
}

resource "aws_subnet" "eks_subnet_b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.16.16.0/20"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "eks-subnet-b"
  }
}

# Create security group for EKS cluster
resource "aws_security_group" "eks_cluster_sg" {
  vpc_id      = aws_vpc.eks_vpc.id
  name        = "eks-cluster-sg"
  description = "Security group for EKS cluster"

  # Ingress rules
  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "eks-cluster-sg"
  }
}

# Create network ACL for subnets
resource "aws_network_acl" "eks_nacl" {
  vpc_id = aws_vpc.eks_vpc.id
  subnet_ids = [aws_subnet.eks_subnet_a.id, aws_subnet.eks_subnet_b.id]
  tags = {
    Name = "eks-nacl"
  }
}

# Create route table for subnets
resource "aws_route_table" "eks_route_table" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "eks-route-table"
  }
}

# Create subnet associations with route table and network ACL
resource "aws_route_table_association" "eks_route_table_association_a" {
  subnet_id      = aws_subnet.eks_subnet_a.id
  route_table_id = aws_route_table.eks_route_table.id
}

resource "aws_route_table_association" "eks_route_table_association_b" {
  subnet_id      = aws_subnet.eks_subnet_b.id
  route_table_id = aws_route_table.eks_route_table.id
}

resource "aws_network_acl_association" "eks_nacl_association_a" {
  subnet_id      = aws_subnet.eks_subnet_a.id
  network_acl_id = aws_network_acl.eks_nacl.id
}

resource "aws_network_acl_association" "eks_nacl_association_b" {
  subnet_id      = aws_subnet.eks_subnet_b.id
  network_acl_id = aws_network_acl.eks_nacl.id
}
