resource "aws_lb" "blr-public-alb" {
  name               = "blr-public-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.project01_public_subnet.id]

  security_groups    = [aws_security_group.project01_public_secgroup01.id]

  tags = {
    Name = "blr-public-alb"
  }
}
resource "aws_lb_target_group" "blr-alb-target-group" {
  name        = "blr-alb-target-group"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = aws_vpc.project01_vpc.id
}

resource "aws_lb_target_group_attachment" "autoscaling_target_attachment" {
  target_group_arn = aws_lb_target_group.blr-alb-target-group.arn
  target_id       = aws_autoscaling_group.project01_autoscaling_group.id
  port            = 443
}
