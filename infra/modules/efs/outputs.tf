# Salidas del módulo EFS
# Superficie de práctica: definir las salidas necesarias

output "efs_id" {
  description = "ID del sistema de archivos EFS"
  value       = aws_efs_file_system.this.id
}

output "efs_arn" {
  description = "ARN del sistema de archivos EFS"
  value       = aws_efs_file_system.this.arn
}

output "efs_dns_name" {
  description = "Nombre DNS del sistema de archivos EFS"
  value       = aws_efs_file_system.this.dns_name
}

output "mount_target_ids" {
  description = "IDs de los mount targets"
  value       = aws_efs_mount_target.this[*].id
}

output "mount_target_ips" {
  description = "IPs de los mount targets"
  value       = aws_efs_mount_target.this[*].ip_address
}

output "access_point_id" {
  description = "ID del access point"
  value       = aws_efs_access_point.this.id
}