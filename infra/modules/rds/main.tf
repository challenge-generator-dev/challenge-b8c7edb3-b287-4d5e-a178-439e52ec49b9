terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}

# Stub: Instancia de base de datos PostgreSQL para la app de pedidos
# Completar con la configuración de seguridad, backups, réplicas, etc.
resource "aws_db_instance" "this" {
  identifier     = var.db_identifier
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = var.port

  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = var.subnet_group_name

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id

  deletion_protection = var.deletion_protection

  tags = var.common_tags
}