# Variables del módulo S3 para almacenamiento de la aplicación de pedidos
# Superficie de práctica: completar con las variables necesarias para el bucket S3

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

variable "bucket_prefix" {
  description = "Prefijo para el nombre del bucket S3"
  type        = string
  default     = "orders-app"
}

variable "enable_versioning" {
  description = "Habilitar versionado en el bucket S3"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Habilitar cifrado en el bucket S3"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "Reglas de ciclo de vida para transición de objetos"
  type = list(object({
    id                = string
    enabled           = bool
    transition_days   = number
    storage_class     = string
  }))
  default = []
}

variable "tags" {
  description = "Tags obligatorios para todos los recursos"
  type        = map(string)
  default     = {}
}