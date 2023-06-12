######## Create Launch Template ########
resource "aws_launch_template" "project01_launch_template" {
  name_prefix   = "project01-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.existing_key_pair

  vpc_security_group_ids = [aws_security_group.project01_private_secgroup01.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "project01-instance"
    }
  }
block_device_mappings {
    device_name           = "/dev/sdf"
    ebs {
      volume_size         = 8
      delete_on_termination = true
    }
  }
  dynamic "network_interfaces" {
    for_each = aws_subnet.project01_private_subnet
    content {
      device_index         = network_interfaces.key
      subnet_id            = network_interfaces.value.id
    }
  }
}



