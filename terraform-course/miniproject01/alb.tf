resource "aws_lb" "project01_public_alb" {
  name               = "project01_public_alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [project01_public_subnet.id]

  security_groups    = [aws_security_group.project01_public_secgroup01.id]

  tags = {
    Name = "project01_public_alb"
  }
}
resource "aws_lb_target_group" "blr_alb_target_group" {
  name        = "blr_alb_target_group"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = aws_vpc.project01_vpc.id
}

resource "aws_lb_target_group_attachment" "ec2_target_attachment" {
  count           = length(var.instances)
  target_group_arn = aws_lb_target_group.blr_alb_target_group.arn
  target_id       = aws_instance.ec2_instances[count.index].id
  port            = 443
}
