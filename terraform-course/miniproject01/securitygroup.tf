######### Create security group #########
resource "aws_security_group" "project01_private_secgroup01" {
  vpc_id      = aws_vpc.project01_vpc.id
  name        = "project01_private-sg"
  description = "project01_private_secgroup01"
  dynamic "ingress" {
    for_each = var.private_sec_ingress_port
    content {
        from_port  = ingress.value
        to_port    = ingress.value
        protocol   = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }
  }
}
resource "aws_security_group" "project01_public_secgroup01" {
  vpc_id      = aws_vpc.project01_vpc.id
  name        = "project01_public-sg"
  description = "project01_public_secgroup01"
  dynamic "ingress" {
    for_each = var.public_sec_ingress_port
    content {
        from_port  = ingress.value
        to_port    = ingress.value
        protocol   = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }
  }
}
