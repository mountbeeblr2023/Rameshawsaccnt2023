# Retrieve VPC IDs
data "aws_vpc" "eks-vpc-useast01" {
  filter {
    name   = "tag:Name"
    values = ["eks-vpc-useast01"]  # Replace with the name or tag of VPC 1
  }
}

data "aws_vpc" "worker-node-useast01" {
  filter {
    name   = "tag:Name"
    values = ["worker-node-useast01"]  # Replace with the name or tag of VPC 2
  }
}

# Create the VPC peering connection
resource "aws_vpc_peering_connection" "peering_connection" {
  peer_vpc_id          = data.aws_vpc.worker-node-useast01.id
  vpc_id               = data.aws_vpc.eks-vpc-useast01.id
  peer_region          = "us-east-1"  # Replace with the appropriate region
  auto_accept          = true
}

# Accept the VPC peering connection request on the other VPC
resource "aws_vpc_peering_connection_accepter" "peering_accepter" {
  provider             = aws
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
}
