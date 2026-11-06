# Valores de variables para el entorno de producción
# Este archivo contiene la configuración específica del ambiente prod

# Configuración general del proyecto
project_name          = "pedidos-app"
environment           = "prod"
region                = "us-east-1"

# Configuración de VPC
vpc_cidr              = "10.0.0.0/16"
available_zones       = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets_cidr   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets_cidr  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
database_subnets_cidr = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

# Configuración de ECS
ecs_cluster_instance_type = "t3.medium"
ecs_cluster_desired_count = 3
ecs_cluster_min_size       = 2
ecs_cluster_max_size       = 6
ecs_cluster_autoscaling_enabled = true

# Configuración de RDS
rds_instance_class    = "db.t3.medium"
rds_allocated_storage = 100
rds_storage_type      = "gp3"
rds_engine            = "postgres"
rds_engine_version    = "15.4"
rds_db_name           = "pedidosdb"
rds_backup_retention_days = 7
rds_skip_final_snapshot = false
rds_final_snapshot_identifier = "pedidos-prod-final-snapshot"

# Configuración de ElastiCache
elasticache_node_type           = "cache.t3.medium"
elasticache_num_cache_nodes     = 2
elasticache_engine              = "redis"
elasticache_engine_version      = "7.0"
elasticache_port                = 6379
elasticache_parameter_group_name = "default.redis7.0"
elasticache_at_rest_encryption  = true
elasticache_transit_encryption  = true

# Configuración de S3
s3_bucket_versioning    = true
s3_enable_server_side_encryption = true
s3_server_side_encryption_algorithm = "AES256"

# Configuración de IAM
iam_role_policy_enabled = true
iam_enable_cloudwatch_logs = true

# Configuración de ALB
alb_enable_deletion_protection = true
alb_idle_timeout               = 60
alb_enable_cross_zone_load_balancing = true

# Configuración de EFS
efs_throughput_mode = "bursting"
efs_performance_mode = "generalPurpose"
efs_encrypted = true

# Tags obligatorios para todos los recursos
tags = {
  Environment = "prod"
  Project     = "pedidos-app"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Owner       = "plataforma"
}