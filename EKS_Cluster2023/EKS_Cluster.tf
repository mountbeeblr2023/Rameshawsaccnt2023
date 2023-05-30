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
  cidr_block              = "10.16.0.0/28"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "eks-subnet-a"
  }
}

resource "aws_subnet" "eks_subnet_b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.16.0.16/28"
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
# VPC Peering Configuration

resource "aws_vpc_peering_connection" "peering" {
  vpc_id               = aws_vpc.eks_vpc.id
  peer_vpc_id          = aws_vpc.worker_vpc.id
  auto_accept          = true
}

resource "aws_route" "rt_vpc1_peering" {
  route_table_id            = aws_route_table.eks_route_table.id
  destination_cidr_block    = aws_vpc.worker_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

resource "aws_route" "rt_vpc2_peering" {
  route_table_id            = aws_route_table.worker_route_table.id
  destination_cidr_block    = aws_vpc.eks_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

# Define local variables to capture EKS VPC component IDs
locals {
  vpc_id            = aws_vpc.eks_vpc.id
  subnet_ids         = [aws_subnet.eks_subnet_a.id, aws_subnet.eks_subnet_b.id]
  security_group_id = aws_security_group.eks_cluster_sg.id
  nacl_id           = aws_network_acl.eks_nacl.id
}


# Retrieve VPC component values using locals
data "aws_vpc" "existing_vpc" {
  id = local.vpc_id
}

data "aws_subnet" "existing_subnet" {
  ids = local.subnet_ids
}

data "aws_security_group" "existing_security_group" {
  id = local.security_group_id
}

# Create EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = [data.aws_subnet.existing_subnet.ids]
    security_group_ids      = [data.aws_security_group.existing_security_group.id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }
}

# Create EKS cluster IAM role and attach necessary policies
resource "aws_iam_role" "eks_cluster_role" {
  name = "my-eks-cluster-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_worker_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_cni_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
}