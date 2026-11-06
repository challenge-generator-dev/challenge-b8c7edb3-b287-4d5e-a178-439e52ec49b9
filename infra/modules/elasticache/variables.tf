variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará ElastiCache"
  type        = string
}

variable "private_subnets" {
  description = "Lista de IDs de subredes privadas para ElastiCache"
  type        = list(string)
}

variable "elasticache_node_type" {
  description = "Tipo de nodo para ElastiCache"
  type        = string
  default     = "cache.t3.micro"
}

variable "num_cache_nodes" {
  description = "Número de nodos en el clúster ElastiCache"
  type        = number
  default     = 1
}

variable "engine_version" {
  description = "Versión del motor de ElastiCache"
  type        = string
  default     = "6.x"
}

variable "parameter_group_name" {
  description = "Nombre del grupo de parámetros para ElastiCache"
  type        = string
  default     = "default.redis6.x"
}

variable "port" {
  description = "Puerto para el clúster ElastiCache"
  type        = number
  default     = 6379
}

variable "tags" {
  description = "Tags comunes para todos los recursos de ElastiCache"
  type        = map(string)
  default     = {}
}