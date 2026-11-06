variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará ECS"
  type        = string
}

variable "private_subnets" {
  description = "Lista de IDs de subredes privadas para ECS"
  type        = list(string)
}

variable "public_subnets" {
  description = "Lista de IDs de subredes públicas para el ALB"
  type        = list(string)
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

variable "container_port" {
  description = "Puerto expuesto por el contenedor"
  type        = number
  default     = 8080
}

variable "desired_count" {
  description = "Número deseado de tareas ECS"
  type        = number
  default     = 1
}

variable "alb_arn" {
  description = "ARN del Application Load Balancer"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL del repositorio ECR donde está la imagen del contenedor"
  type        = string
}

variable "tags" {
  description = "Tags comunes para todos los recursos de ECS"
  type        = map(string)
  default     = {}
}