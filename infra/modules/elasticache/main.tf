resource "random_id" "redis_suffix" {
  byte_length = 4
}

resource "aws_elasticache_subnet_group" "main" {
  name       = "elasticache-subnet-${var.environment}"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "elasticache-subnet-${var.environment}"
    }
  )
}

resource "aws_security_group" "elasticache" {
  name        = "elasticache-sg-${var.environment}"
  description = "Security group para ElastiCache Redis"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.redis_port
    to_port     = var.redis_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Acceso Redis"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Salida permitida"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "elasticache-sg-${var.environment}"
    }
  )
}

resource "aws_elasticache_replication_group" "main" {
  replication_group_id       = "redis-${var.environment}-${random_id.redis_suffix.hex}"
  replication_group_description = "Redis cluster para cache de sesiones"

  engine               = "redis"
  engine_version      = var.redis_version
  node_type           = var.node_type
  number_cache_clusters = var.num_cache_nodes

  port                 = var.redis_port
  parameter_group_name = var.parameter_group_name
  subnet_group_name    = aws_elasticache_subnet_group.main.name
  security_group_ids   = [aws_security_group.elasticache.id]

  at_rest_encryption_enabled = var.enable_encryption
  transit_encryption_enabled = var.enable_encryption
  auth_token_enabled         = var.enable_encryption

  automatic_failover_enabled = var.num_cache_nodes > 1 ? true : false
  multi_az_enabled          = var.num_cache_nodes > 1 ? true : false

  snapshot_retention_limit   = var.snapshot_retention_days
  snapshot_window           = var.snapshot_window
  maintenance_window        = var.maintenance_window

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately         = var.apply_immediately

  log_delivery_configuration {
    destination      = aws_elasticache_cloudwatch_log_group.redis_slow.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }

  log_delivery_configuration {
    destination      = aws_elasticache_cloudwatch_log_group.redis_engine.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "redis-${var.environment}"
    }
  )
}

resource "aws_elasticache_cloudwatch_log_group" "redis_slow" {
  name              = "/aws/elasticache/redis/${var.environment}/slow-log"
  retention_in_days = var.log_retention_days

  tags = merge(
    var.common_tags,
    {
      Name = "redis-slow-log-${var.environment}"
    }
  )
}

resource "aws_elasticache_cloudwatch_log_group" "redis_engine" {
  name              = "/aws/elasticache/redis/${var.environment}/engine-log"
  retention_in_days = var.log_retention_days

  tags = merge(
    var.common_tags,
    {
      Name = "redis-engine-log-${var.environment}"
    }
  )
}