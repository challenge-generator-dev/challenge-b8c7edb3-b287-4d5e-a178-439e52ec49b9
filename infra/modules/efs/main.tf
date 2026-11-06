# Módulo EFS - Sistema de archivos para persistencia compartida
# Superficie de práctica: completar la implementación del recurso EFS

resource "aws_efs_file_system" "this" {
  # STUB: Completar con la configuración del sistema de archivos
  # Referencia: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system
  
  # Tags obligatorios
  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terraform"
  }
}

resource "aws_efs_mount_target" "this" {
  # STUB: Completar para crear mount targets en las subnets especificadas
  # El EFS necesita mount targets en cada AZ donde se use
  # file_system_id = aws_efs_file_system.this.id
  # subnet_id      = 
  # security_groups = 
}

resource "aws_efs_access_point" "this" {
  # STUB: Opcional - configurar access point para acceso controlado
  # file_system_id = aws_efs_file_system.this.id
}