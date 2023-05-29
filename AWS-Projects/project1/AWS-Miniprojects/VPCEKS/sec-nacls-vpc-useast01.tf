# Define security group for EKS control plane
resource "aws_security_group" "eks_control_plane_sg01" {
  vpc_id      = data.aws_vpc.eks-vpc-useast01.id
  description = "Security group for EKS control plane"

  # Ingress rule for control plane
  ingress {
    description = "Inbound rule for EKS control plane"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with more specific CIDR if desired
  }

  # Egress rule for control plane
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define security group for worker nodes
resource "aws_security_group" "worker_nodes_sg01" {
  vpc_id      = data.aws_vpc.worker-node-useast01.id
  description = "Security group for EKS worker nodes"

  # Ingress rule for worker nodes
  ingress {
    description      = "Inbound rule for worker nodes"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    security_groups = [aws_security_group.eks_control_plane_sg01.id]
  }

  # Egress rule for worker nodes
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create NACL for EKS control plane VPC
resource "aws_network_acl" "eks_control_plane_nacl01" {
  vpc_id = data.aws_vpc.eks-vpc-useast01.id

  # Inbound rule for control plane
  ingress {
    rule_number   = 100
    protocol      = "tcp"
    action        = "allow"
    from_port     = 443
    to_port       = 443
    cidr_block    = "0.0.0.0/0"
  }

  # Outbound rule for control plane
  egress {
    rule_number   = 100
    protocol      = "-1"
    action        = "allow"
    from_port     = 0
    to_port       = 0
    cidr_block    = "0.0.0.0/0"
  }
}

# Create NACL for worker nodes VPC
resource "aws_network_acl" "worker_nodes_nacl01" {
  vpc_id = data.aws_vpc.worker-node-useast01.id

  # Inbound rule for worker nodes
  ingress {
    rule_number      = 100
    protocol         = "tcp"
    action           = "allow"
    from_port        = 0
    to_port          = 65535
    rule_action      = "allow"
    cidr_block       = "0.0.0.0/0"
  }

  # Outbound rule for worker nodes
  egress {
    rule_number   = 100
    protocol      = "-1"
    action        = "allow"
    from_port     = 0
    to_port       = 0
    cidr_block       = "0.0.0.0/0"
  }
}

