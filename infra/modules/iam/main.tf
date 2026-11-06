# Módulo IAM para roles y políticas
# SUPERFICIE DE PRÁCTICA: completar la implementación de IAM

# TODO: Implementar rol para ECS Task Execution
# El rol debe tener:
# - Política de ejecución que permita:
#   - Pull de imágenes desde ECR
#   - Escritura en CloudWatch Logs
#   - Acceso a Secrets Manager
# - Trust policy para ecs-tasks.amazonaws.com
# - Tags obligatorios

# TODO: Implementar rol para ECS Task (aplicación)
# El rol debe tener:
# - Política que permita:
#   - Acceso a S3 (lectura de imágenes)
#   - Acceso a DynamoDB (tablas de la app)
#   - Acceso a Secrets Manager
#   - Publicación en CloudWatch Logs
# - Trust policy para ecs-tasks.amazonaws.com
# - Tags obligatorios

# TODO: Implementar rol para Lambda
# El rol debe tener:
# - Política que permita:
#   - Acceso a S3 (procesamiento de imágenes)
#   - Acceso a DynamoDB
#   - Acceso a SNS (notificaciones)
#   - Escritura en CloudWatch Logs
# - Trust policy para lambda.amazonaws.com
# - Tags obligatorios

# TODO: Implementar políticas gestionadas (inline policies)
# - Policy para acceso a ECR
# - Policy para acceso a CloudWatch
# - Policy para acceso a Secrets Manager