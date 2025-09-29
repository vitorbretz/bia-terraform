resource "aws_lb" "bia" {
  name               = "bia-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.bia-alb.id]
  subnets            = [local.subnet_zona_a, local.subnet_zona_b]
}
resource "aws_lb_target_group" "tg-bia" {
  name_prefix          = "tgbia-"
  vpc_id               = local.vpc_id
  port                 = 80
  protocol             = "HTTP"
  target_type          = "instance"
  deregistration_delay = 30

  health_check {
    enabled             = true
    interval            = 10
    path                = "/api/versao"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
    matcher             = 200
  }
}

resource "aws_lb_listener" "bia" {
  load_balancer_arn = aws_lb.bia.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-bia.arn
  }

}


output "alb_url" {
  value = aws_lb.bia.dns_name

}