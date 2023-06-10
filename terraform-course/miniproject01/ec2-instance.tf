
resource "aws_instance" "ec2_instances" {
  count = length(var.instances)

  ami           = var.instances[count.index].ami_id
  instance_type = var.instances[count.index].instance_type

  tags = {
    Name = var.instances[count.index].name
  }
}