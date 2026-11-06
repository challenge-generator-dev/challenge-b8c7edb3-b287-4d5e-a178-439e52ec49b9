provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "pedidos-app"
      ManagedBy   = "terraform"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "ecs" {
  source = "./modules/ecs"

  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  public_subnet_ids     = module.vpc.public_subnet_ids
  ecs_cluster_name      = var.ecs_cluster_name
  container_image       = var.container_image
  container_port        = var.container_port
  desired_count         = var.desired_count
  max_count             = var.max_count
  min_count             = var.min_count
}

module "rds" {
  source = "./modules/rds"

  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnet_ids
  db_name             = var.db_name
  db_instance_class   = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_engine_version   = var.db_engine_version
}

module "elasticache" {
  source = "./modules/elasticache"

  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnet_ids
  node_type        = var.elasticache_node_type
  num_cache_nodes  = var.num_cache_nodes
  engine_version   = var.elasticache_engine_version
}

module "s3" {
  source = "./modules/s3"

  environment = var.environment
}

module "iam" {
  source = "./modules/iam"

  environment     = var.environment
  ecs_cluster_arn = module.ecs.ecs_cluster_arn
  ecs_task_role_arn = module.ecs.ecs_task_role_arn
}

module "alb" {
  source = "./modules/alb"

  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  target_group_arn    = module.ecs.target_group_arn
  alb_name            = var.alb_name
}

module "efs" {
  source = "./modules/efs"

  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnet_ids
  efs_throughput_mode = var.efs_throughput_mode
  efs_performance_mode = var.efs_performance_mode
}