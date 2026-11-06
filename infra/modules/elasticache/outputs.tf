output "redis_endpoint" {
  description = "Endpoint primario del cluster Redis"
  value       = aws_elasticache_replication_group.main.primary_endpoint_address
}

output "redis_reader_endpoint" {
  description = "Endpoint de lectura del cluster Redis"
  value       = aws_elasticache_replication_group.main.reader_endpoint_address
}

output "redis_port" {
  description = "Puerto de Redis"
  value       = aws_elasticache_replication_group.main.port
}

output "redis_replication_group_id" {
  description = "ID del grupo de replicación"
  value       = aws_elasticache_replication_group.main.id
}

output "redis_arn" {
  description = "ARN del grupo de replicación"
  value       = aws_elasticache_replication_group.main.arn
}

output "redis_security_group_id" {
  description = "ID del security group de ElastiCache"
  value       = aws_security_group.elasticache.id
}

output "redis_cache_nodes" {
  description = "Información de los nodos del cluster"
  value       = aws_elasticache_replication_group.main.cache_nodes
}