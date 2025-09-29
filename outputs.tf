output "instance_id" {
  value       = aws_instance.bia-dev.id
  description = "value of the instance id"
}
output "instance_type" {
  value       = aws_instance.bia-dev.instance_type
  description = "value of the instance type"

}
output "instance_security_group" {
  value       = aws_instance.bia-dev.security_groups
  description = "security group id"

}

output "rds_endpoint" {
  value       = aws_db_instance.bia.endpoint
  description = "rds endpoint"

}


output "bia_repo_url" {
  value       = aws_ecr_repository.bia.repository_url
  description = "ECR repository URL for the BIA application"

}

output "rds_secret_name" {
  value       = data.aws_secretsmanager_secret.bia_db.name
  description = "nome do meu segredo"

}