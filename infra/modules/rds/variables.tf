variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará RDS"
  type        = string
}

variable "database_subnets" {
  description = "Lista de IDs de subredes de base de datos"
  type        = list(string)
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

variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "ordersdb"
}

variable "database_username" {
  description = "Usuario maestro de la base de datos"
  type        = string
  default     = "admin"
}

variable "database_password" {
  description = "Contraseña para el usuario maestro de la base de datos"
  type        = string
  sensitive   = true
}

variable "skip_final_snapshot" {
  description = "Omitir snapshot final al eliminar la instancia RDS"
  type        = bool
  default     = true
}

variable "storage_encrypted" {
  description = "Habilitar cifrado de almacenamiento para RDS"
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Habilitar despliegue multi-AZ para RDS"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags comunes para todos los recursos de RDS"
  type        = map(string)
  default     = {}
}