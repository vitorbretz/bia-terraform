resource "aws_ecs_task_definition" "bia_web" {
  family        = "task-def-bia"
  network_mode  = "bridge"
  task_role_arn = aws_iam_role.ecs_task_role.arn


  container_definitions = jsonencode([
    {
      name              = "bia"
      image             = "${aws_ecr_repository.bia.repository_url}:latest"
      cpu               = 1024
      memoryReservation = 400
      essential         = true

      portMappings = [
        {
          containerPort = 8080
          hostPort      = 0
        }
      ]

      environment = [
        {
          name  = "DB_PORT"
          value = "5432"
        },
        {
          name  = "DB_HOST"
          value = aws_db_instance.bia.address
        },
        {
          name  = "DB_SECRET_NAME"
          value = "${data.aws_secretsmanager_secret.bia_db.name}"
        },
        {
          name  = "AWS_REGION"
          value = "us-east-1"
          }, {
          name  = "DEBUG_SECRET"
          value = "false"
        }



      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_bia_web.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "bia"
        }
      }
      runtimePlatform = {
        cpuArchitecture       = "X86_64"
        operatingSystemFamily = "LINUX"
      }
    }
  ])
}
