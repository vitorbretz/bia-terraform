resource "aws_ecs_service" "bia_web" {
  name            = "service-bia-web"
  cluster         = aws_ecs_cluster.cluster_bia.id
  task_definition = aws_ecs_task_definition.bia_web.arn
  desired_count   = 2

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bia.name
    weight            = 100
    base              = 1
  }


  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 100


  depends_on = [aws_lb_listener.bia]  

  load_balancer {
    target_group_arn = aws_lb_target_group.tg-bia.arn
    container_name   = "bia"
    container_port   = 8080
  }


}