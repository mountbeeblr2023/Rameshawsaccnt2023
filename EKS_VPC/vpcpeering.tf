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
