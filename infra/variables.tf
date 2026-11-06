variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Perfil de AWS CLI a utilizar para autenticación"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
  default     = "mobile-orders-app"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "database_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes de base de datos"
  type        = list(string)
  default     = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
}

variable "ecs_task_cpu" {
  description = "CPU asignada a la tarea ECS"
  type        = number
  default     = 256
}

variable "ecs_task_memory" {
  description = "Memoria asignada a la tarea ECS"
  type        = number
  default     = 512
}

variable "rds_engine_version" {
  description = "Versión del motor de RDS"
  type        = string
  default     = "15.4"
}

variable "rds_instance_class" {
  description = "Clase de instancia para RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Almacenamiento asignado para RDS en GB"
  type        = number
  default     = 20
}

variable "elasticache_node_type" {
  description = "Tipo de nodo para ElastiCache"
  type        = string
  default     = "cache.t3.micro"
}

variable "tags" {
  description = "Tags comunes para todos los recursos"
  type        = map(string)
  default = {
    Project     = "mobile-orders-app"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}