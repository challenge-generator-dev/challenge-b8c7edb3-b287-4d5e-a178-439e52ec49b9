# Stub: Salidas del módulo ECS
# Proporcionar los valores que otros módulos necesitan

output "cluster_arn" {
  description = "ARN del cluster ECS"
  value       = aws_ecs_cluster.this.arn
}

output "cluster_name" {
  description = "Nombre del cluster ECS"
  value       = aws_ecs_cluster.this.name
}

output "cluster_id" {
  description = "ID del cluster ECS"
  value       = aws_ecs_cluster.this.id
}

output "service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.api_service.name
}

output "service_arn" {
  description = "ARN del servicio ECS"
  value       = aws_ecs_service.api_service.arn
}