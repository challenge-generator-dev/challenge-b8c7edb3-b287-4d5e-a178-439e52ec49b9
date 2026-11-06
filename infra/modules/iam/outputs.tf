output "ecs_task_execution_role_arn" {
  description = "ARN del rol de ejecución de tareas ECS"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_execution_role_name" {
  description = "Nombre del rol de ejecución de tareas ECS"
  value       = aws_iam_role.ecs_task_execution.name
}

output "ecs_task_role_arn" {
  description = "ARN del rol de tarea ECS"
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_task_role_name" {
  description = "Nombre del rol de tarea ECS"
  value       = aws_iam_role.ecs_task.name
}