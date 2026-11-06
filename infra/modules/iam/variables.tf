# Variables del módulo IAM para gestión de permisos y roles
# Superficie de práctica: completar con las variables necesarias para roles y políticas IAM

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

variable "ecs_cluster_name" {
  description = "Nombre del cluster ECS donde se ejecutará la aplicación"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "Nombre del rol de ejecución de tareas ECS"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "Nombre del rol de tareas ECS"
  type        = string
  default     = "ecsTaskRole"
}

variable "s3_bucket_names" {
  description = "Lista de buckets S3 a los que la aplicación necesita acceso"
  type        = list(string)
  default     = []
}

variable "dynamodb_table_names" {
  description = "Lista de tablas DynamoDB a las que la aplicación necesita acceso"
  type        = list(string)
  default     = []
}

variable "allow_ecr_pull" {
  description = "Permitir pull de imágenes desde ECR"
  type        = bool
  default     = true
}

variable "allow_secrets_manager" {
  description = "Permitir acceso a Secrets Manager"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags obligatorios para todos los recursos"
  type        = map(string)
  default     = {}
}