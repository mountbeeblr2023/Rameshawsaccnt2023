resource "aws_network_acl" "private" {
  vpc_id = var.vpc_id
}