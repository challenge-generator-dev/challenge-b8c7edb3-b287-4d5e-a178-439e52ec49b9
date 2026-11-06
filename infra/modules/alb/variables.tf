# Variables del módulo ALB para balanceador de carga de la aplicación
# Superficie de práctica: completar con las variables necesarias para el ALB

variable "project_name" {
  description = "Nombre del proyecto para naming de recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser: dev, staging o prod."
  }
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará el ALB"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subnets donde se crearán las AZs del ALB"
  type        = list(string)
}

variable "security_groups" {
  description = "Lista de IDs de security groups para el ALB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación del ALB"
  type        = bool
  default     = false
}

variable "enable_access_logs" {
  description = "Habilitar logs de acceso al ALB"
  type        = bool
  default     = true
}

variable "access_log_bucket" {
  description = "Bucket S3 para almacenar logs de acceso del ALB"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ARN del certificado ACM para HTTPS"
  type        = string
  default     = ""
}

variable "health_check_path" {
  description = "Ruta para health checks del ALB"
  type        = string
  default     = "/health"
}

variable "health_check_interval" {
  description = "Intervalo de health checks en segundos"
  type        = number
  default     = 30
}

variable "target_groups" {
  description = "Configuración de target groups para el ALB"
  type = list(object({
    name     = string
    port     = number
    protocol = string
    path     = string
  }))
  default = []
}

variable "tags" {
  description = "Tags obligatorios para todos los recursos"
  type        = map(string)
  default     = {}
}