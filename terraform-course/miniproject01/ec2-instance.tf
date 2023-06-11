
resource "aws_instance" "ec2_instances" {
  count = length(var.instances)

  ami                         = var.instances[count.index].ami_id
  instance_type               = var.instances[count.index].instance_typesubnet_id = aws_subnet.project01_private_subnet[count.index].id  
  vpc_security_group_ids      = [aws_security_group.project01_private_secgroup01[count.index].id]  
  associate_public_ip_address = false 

  tags = {
    Name = var.instances[count.index].name
  }
}