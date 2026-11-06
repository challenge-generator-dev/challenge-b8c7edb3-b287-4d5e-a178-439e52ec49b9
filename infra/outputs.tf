# Outputs de la infraestructura - SUPERFICIE DE PRACTICA
# El estudiante debe implementar las salidas que exponen los recursos creados

# Output del VPC
output "vpc_id" {
  description = "ID del VPC creado"
  value       = module.vpc.vpc_id
}

# Output del Cluster ECS
output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = module.ecs.cluster_name
}

# Output de la base de datos RDS
output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.rds.endpoint
  sensitive   = true
}

# Output del Elasticache
output "elasticache_endpoint" {
  description = "Endpoint del cluster ElastiCache"
  value       = module.elasticache.endpoint
}

# Output del ALB
output "alb_dns_name" {
  description = "Nombre DNS del Application Load Balancer"
  value       = module.alb.dns_name
}

# Output del bucket S3
output "s3_bucket_name" {
  description = "Nombre del bucket S3 para artefactos"
  value       = module.s3.bucket_name
}