# Módulo S3 para almacenamiento de imágenes y archivos
# SUPERFICIE DE PRÁCTICA: completar la implementación de buckets S3

# TODO: Implementar bucket para imágenes de productos
# El bucket debe tener:
# - Versioning habilitado
# - Encriptación SSE-KMS
# - Lifecycle rules para transición a Glacier
# - Tags obligatorios: Environment, Project, ManagedBy

# TODO: Implementar bucket para archivos temporales
# El bucket debe tener:
# - Lifecycle rules paraauto-eliminación después de 7 días
# - Bloqueo público por defecto
# - Tags obligatorios

# TODO: Implementar bucket para logs de acceso
# El bucket debe tener:
# - Retención de logs por 90 días
# - Prefijo específico para organización
# - Tags obligatorios