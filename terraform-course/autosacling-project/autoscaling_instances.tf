######## Create Launch Template ########
resource "aws_launch_template" "project01_launch_template" {
  name_prefix   = "project01-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.existing_key_pair

  #vpc_security_group_ids = [aws_security_group.project01_private_secgroup01.id]

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
    for_each = range(length(aws_subnet.project01_private_subnet))
    content {
      # device_index         = network_interfaces.key
      device_index         = 1
      subnet_id            = aws_subnet.project01_private_subnet[network_interfaces.key].id
      security_groups      = [aws_security_group.project01_private_secgroup01.id]
    }
  }
}

############### Auto scaling group & policy ###############
resource "aws_autoscaling_group" "project01_autoscaling_group" {
  name                      = "project01-asg"
  launch_template {
    id                       = aws_launch_template.project01_launch_template.id
    version                  = "$Latest"
  }

  min_size                  = 1
  max_size                  = 4
  desired_capacity          = 2
  vpc_zone_identifier       = aws_subnet.project01_private_subnet[*].id
  tag {
    key                      = "Name"
    value                    = "project01-asg"
    propagate_at_launch     = true
  }
}
