terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}

# Stub: Cluster ECS Fargate para el backend de la app de pedidos
# La persona completará la definición del cluster con la configuración apropiada
resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.common_tags
}

# Stub: Servicio ECS para ejecutar los contenedores de la API
# Completar con la definición del task, subnets, security groups, etc.
resource "aws_ecs_service" "api_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [aws_ecs_cluster.this]

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = var.common_tags
}