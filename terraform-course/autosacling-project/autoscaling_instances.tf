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
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "project01_autoscaling_group" {
  name                      = "project01-asg"
  launch_template {
    id      = aws_launch_template.project01_launch_template.id
    version = "$Latest"
  }
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 2
  health_check_type         = "ELB"
  health_check_grace_period = 300
  count                     = length(aws_subnet.project01_private_subnet)
  vpc_zone_identifier       = aws_subnet.project01_private_subnet[count.index].id
  target_group_arns         = [aws_lb_target_group.blr-alb-target-group.arn]
  termination_policies      = ["Default"]
}
