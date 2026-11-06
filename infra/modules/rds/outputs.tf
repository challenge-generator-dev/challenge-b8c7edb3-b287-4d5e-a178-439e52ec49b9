output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = aws_db_instance.main.endpoint
}

output "rds_port" {
  description = "Puerto de la base de datos RDS"
  value       = aws_db_instance.main.port
}

output "rds_arn" {
  description = "ARN de la instancia RDS"
  value       = aws_db_instance.main.arn
}

output "rds_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.main.name
}

output "rds_security_group_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}