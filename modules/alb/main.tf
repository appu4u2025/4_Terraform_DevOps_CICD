variable "subnets" {}
variable "security_group_id" {}
variable "vpc_id" {}

resource "aws_lb" "alb" {
    name = "terraform-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.security_group_id]
    subnets = var.subnets
}
resource "aws_lb_target_group" "tg" {
    name = "terraform-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}