# Valores de variables para el entorno de desarrollo
# Configuración ligera para pruebas y desarrollo

# Configuración general del proyecto
project_name          = "pedidos-app"
environment           = "dev"
region                = "us-east-1"

# Configuración de VPC - rango más pequeño para dev
vpc_cidr              = "172.16.0.0/20"
available_zones       = ["us-east-1a", "us-east-1b"]
public_subnets_cidr   = ["172.16.1.0/24", "172.16.2.0/24"]
private_subnets_cidr  = ["172.16.11.0/24", "172.16.12.0/24"]
database_subnets_cidr = ["172.16.21.0/24", "172.16.22.0/24"]

# Configuración de ECS - instancias más pequeñas para dev
ecs_cluster_instance_type = "t3.small"
ecs_cluster_desired_count = 1
ecs_cluster_min_size       = 1
ecs_cluster_max_size       = 2
ecs_cluster_autoscaling_enabled = false

# Configuración de RDS - instancia mínima para dev
rds_instance_class    = "db.t3.micro"
rds_allocated_storage = 20
rds_storage_type      = "gp3"
rds_engine            = "postgres"
rds_engine_version    = "15.4"
rds_db_name           = "pedidosdb_dev"
rds_backup_retention_days = 1
rds_skip_final_snapshot = true
rds_final_snapshot_identifier = ""

# Configuración de ElastiCache - nodo único para dev
elasticache_node_type           = "cache.t3.micro"
elasticache_num_cache_nodes     = 1
elasticache_engine              = "redis"
elasticache_engine_version      = "7.0"
elasticache_port                = 6379
elasticache_parameter_group_name = "default.redis7.0"
elasticache_at_rest_encryption  = false
elasticache_transit_encryption  = false

# Configuración de S3
s3_bucket_versioning    = true
s3_enable_server_side_encryption = false
s3_server_side_encryption_algorithm = "AES256"

# Configuración de IAM
iam_role_policy_enabled = true
iam_enable_cloudwatch_logs = true

# Configuración de ALB
alb_enable_deletion_protection = false
alb_idle_timeout               = 60
alb_enable_cross_zone_load_balancing = true

# Configuración de EFS
efs_throughput_mode = "bursting"
efs_performance_mode = "generalPurpose"
efs_encrypted = false

# Tags obligatorios para todos los recursos en dev
tags = {
  Environment = "dev"
  Project     = "pedidos-app"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Owner       = "plataforma"
}