variable "efs_name" {
  description = "Nombre del sistema de archivos EFS"
  type        = string
  default     = "app-efs"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará el EFS"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subnets donde se montará el EFS"
  type        = list(string)
}

variable "performance_mode" {
  description = "Modo de rendimiento del EFS (generalPurpose, maxIO)"
  type        = string
  default     = "generalPurpose"
}

variable "throughput_mode" {
  description = "Modo de throughput (bursting, provisioned)"
  type        = string
  default     = "bursting"
}

variable "provisioned_throughput_mibps" {
  description = "Throughput provisionado en MiB/s (solo si throughput_mode es provisioned)"
  type        = number
  default     = null
}

variable "encrypted" {
  description = "Habilitar cifrado en reposo"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags aplicados a los recursos"
  type        = map(string)
  default     = {}
}