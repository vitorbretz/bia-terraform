resource "aws_cloudwatch_log_group" "ecs_bia_web" {
  name              = "/ecs/bia-web"
  retention_in_days = 7

  tags = {
    Name        = "ecs-bia-web-log-group"
    Environment = "production"
  }
}