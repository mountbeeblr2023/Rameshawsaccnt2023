
# Define VPC peering connection
resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id   = aws_vpc.worker_vpc.id        # Worker node VPC ID
  vpc_id        = aws_vpc.eks_vpc.id       # Control plane VPC ID
  auto_accept   = true
}

# Accept VPC peering connection from the worker VPC side
resource "aws_vpc_peering_connection_accepter" "vpc_peering_accepter" {
  provider      = aws.us-east-1
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  auto_accept   = true
}