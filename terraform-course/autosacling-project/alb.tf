# resource "aws_lb" "blr-public-alb" {
#   name               = "blr-public-alb"
#   internal           = false
#   load_balancer_type = "application" 
#   depends_on         = [aws_autoscaling_group.project01_autoscaling_group]          
#  #count              = length(aws_subnet.project01_public_subnet)
#  #subnets            = [aws_subnet.project01_public_subnet[count.index].id]
#   subnets           = [aws_subnet.project01_public_subnet[0].id, aws_subnet.project01_public_subnet[1].id]
#   security_groups    = [aws_security_group.project01_public_secgroup01.id]

#   tags = {
#     Name = "blr-public-alb"
#   }
# }
# resource "aws_lb_target_group" "blr-alb-target-group" {
#   name        = "blr-alb-target-group"
#   port        = 443
#   protocol    = "HTTPS"
#   vpc_id      = aws_vpc.project01_vpc.id
# }

# resource "aws_lb_target_group_attachment" "autoscaling_target_attachment" {
#   target_group_arn = aws_lb_target_group.blr-alb-target-group.arn
#  #count            = length(aws_autoscaling_group.project01_autoscaling_group)
#  #target_id        = aws_autoscaling_group.project01_autoscaling_group[count.index].id
#   target_id        = [aws_autoscaling_group.project01_autoscaling_group.id]
#   port             = 443
# }
