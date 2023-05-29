# VPC Peering Configuration

resource "aws_vpc_peering_connection" "peering" {
  vpc_id               = aws_vpc.eks_vpc.id
  peer_vpc_id          = aws_vpc.worker_vpc.id
  peer_region          = "us-east-1"
  auto_accept          = true
}

# VPC 1 Configuration

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.16.0.0/20"

  # Add other VPC configuration here (e.g., tags, DNS support, etc.)
}

# VPC 2 Configuration

resource "aws_vpc" "worker_vpc" {
  cidr_block = "10.17.0.0/24"

  # Add other VPC configuration here (e.g., tags, DNS support, etc.)
}
