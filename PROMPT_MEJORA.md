# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/vpc/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/vpc/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/vpc/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/ecs/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/ecs/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/ecs/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/rds/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/rds/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/rds/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/elasticache/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/elasticache/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/elasticache/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/s3/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/s3/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/s3/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/iam/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/iam/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/iam/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/alb/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/alb/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/alb/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/efs/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/efs/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/efs/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `client` expone http (api: http://api.pedidos.example.com):
  - `GET /orders`
  - `GET /orders/{id}`
  - `POST /orders`
  - `GET /products`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `client/lib/presentation/blocs/order/order_bloc.dart`
- `client/lib/presentation/blocs/order/order_state.dart`

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261106172943501), Aprovisiona con Terraform los recursos que consume la aplicacion movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de API de app de pedidos con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Terraform — objetivo: Configurar el entorno de Terraform para el proyecto. — entregable (NO resolver): Archivo `main.tf` con la configuración inicial de Terraform.
- Fase 2: Aprovisionamiento de recursos — objetivo: Aprovisionar los recursos necesarios para el backend utilizando Terraform. — entregable (NO resolver): Recursos aprovisionados y verificados para el backend de la aplicación.
- Fase 3: Despliegue de la API — objetivo: Desplegar la API de la aplicación de pedidos utilizando la infraestructura aprovisionada. — entregable (NO resolver): API de la aplicación de pedidos desplegada y documentada.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/providers.tf ===
terraform {
  required_version = "1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

// === ARCHIVO: infra/variables.tf ===
variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Perfil de AWS CLI a utilizar para autenticación"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
  default     = "mobile-orders-app"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "database_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes de base de datos"
  type        = list(string)
  default     = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
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

variable "elasticache_node_type" {
  description = "Tipo de nodo para ElastiCache"
  type        = string
  default     = "cache.t3.micro"
}

variable "tags" {
  description = "Tags comunes para todos los recursos"
  type        = map(string)
  default = {
    Project     = "mobile-orders-app"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

// === ARCHIVO: infra/modules/vpc/variables.tf ===
variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
}

variable "public_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
}

variable "database_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes de base de datos"
  type        = list(string)
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar un único NAT Gateway para todas las subredes privadas"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar hostnames DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags comunes para todos los recursos de la VPC"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: infra/modules/ecs/variables.tf ===
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

// === ARCHIVO: infra/modules/rds/variables.tf ===
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

// === ARCHIVO: infra/modules/elasticache/variables.tf ===
variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará ElastiCache"
  type        = string
}

variable "private_subnets" {
  description = "Lista de IDs de subredes privadas para ElastiCache"
  type        = list(string)
}

variable "elasticache_node_type" {
  description = "Tipo de nodo para ElastiCache"
  type        = string
  default     = "cache.t3.micro"
}

variable "num_cache_nodes" {
  description = "Número de nodos en el clúster ElastiCache"
  type        = number
  default     = 1
}

variable "engine_version" {
  description = "Versión del motor de ElastiCache"
  type        = string
  default     = "6.x"
}

variable "parameter_group_name" {
  description = "Nombre del grupo de parámetros para ElastiCache"
  type        = string
  default     = "default.redis6.x"
}

variable "port" {
  description = "Puerto para el clúster ElastiCache"
  type        = number
  default     = 6379
}

variable "tags" {
  description = "Tags comunes para todos los recursos de ElastiCache"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: infra/modules/s3/variables.tf ===
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

// === ARCHIVO: infra/modules/iam/variables.tf ===
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

// === ARCHIVO: infra/modules/alb/variables.tf ===
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

// === ARCHIVO: infra/modules/efs/variables.tf ===
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

// === ARCHIVO: infra/modules/vpc/main.tf ===
# Stub: Implementar VPC con subnets públicas y privadas, NAT Gateway

# VPC principal
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(var.tags, {
    Name = "${var.project_name}-vpc-${var.environment}"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, {
    Name = "${var.project_name}-igw-${var.environment}"
  })
}

# Subnets públicas
resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
    Type = "public"
  })
}

# Subnets privadas
resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]
  tags = merge(var.tags, {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
    Type = "private"
  })
}

# Elastic IP para NAT Gateway
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway ? length(var.availability_zones) : 0
  domain = "vpc"
  tags = merge(var.tags, {
    Name = "${var.project_name}-nat-eip-${count.index + 1}"
  })
  depends_on = [aws_internet_gateway.main]
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  count         = var.enable_nat_gateway ? length(var.availability_zones) : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = merge(var.tags, {
    Name = "${var.project_name}-nat-gw-${count.index + 1}"
  })
  depends_on = [aws_internet_gateway.main]
}

# Tablas de rutas para subnets públicas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(var.tags, {
    Name = "${var.project_name}-public-rt-${var.environment}"
  })
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Tablas de rutas para subnets privadas
resource "aws_route_table" "private" {
  count  = var.enable_nat_gateway ? length(var.availability_zones) : 0
  vpc_id = aws_vpc.main.id
  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[0].id
    }
  }
  tags = merge(var.tags, {
    Name = "${var.project_name}-private-rt-${var.environment}"
  })
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id
}

// === ARCHIVO: infra/modules/vpc/outputs.tf ===
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = aws_subnet.private[*].id
}

output "availability_zones" {
  description = "Zonas de disponibilidad utilizadas"
  value       = var.availability_zones
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways"
  value       = var.enable_nat_gateway ? aws_nat_gateway.main[*].id : []
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs de las tablas de rutas privadas"
  value       = var.enable_nat_gateway ? aws_route_table.private[*].id : []
}

// === ARCHIVO: infra/modules/ecs/main.tf ===
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

// === ARCHIVO: infra/modules/ecs/outputs.tf ===
# Stub: Salidas del módulo ECS
# Proporcionar los valores que otros módulos necesitan

output "cluster_arn" {
  description = "ARN del cluster ECS"
  value       = aws_ecs_cluster.this.arn
}

output "cluster_name" {
  description = "Nombre del cluster ECS"
  value       = aws_ecs_cluster.this.name
}

output "cluster_id" {
  description = "ID del cluster ECS"
  value       = aws_ecs_cluster.this.id
}

output "service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.api_service.name
}

output "service_arn" {
  description = "ARN del servicio ECS"
  value       = aws_ecs_service.api_service.arn
}

// === ARCHIVO: infra/modules/rds/main.tf ===
terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}

# Stub: Instancia de base de datos PostgreSQL para la app de pedidos
# Completar con la configuración de seguridad, backups, réplicas, etc.
resource "aws_db_instance" "this" {
  identifier     = var.db_identifier
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = var.port

  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = var.subnet_group_name

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id

  deletion_protection = var.deletion_protection

  tags = var.common_tags
}

// === ARCHIVO: infra/modules/rds/outputs.tf ===
output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = aws_db_instance.main.endpoint
}

output "rds_port" {
  description = "Puerto de la base de datos RDS"
  value       = aws_db_instance.main.port
}

output "rds_arn" {
  description = "ARN de la instancia RDS"
  value       = aws_db_instance.main.arn
}

output "rds_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.main.name
}

output "rds_security_group_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}

// === ARCHIVO: infra/modules/elasticache/main.tf ===
resource "random_id" "redis_suffix" {
  byte_length = 4
}

resource "aws_elasticache_subnet_group" "main" {
  name       = "elasticache-subnet-${var.environment}"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "elasticache-subnet-${var.environment}"
    }
  )
}

resource "aws_security_group" "elasticache" {
  name        = "elasticache-sg-${var.environment}"
  description = "Security group para ElastiCache Redis"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.redis_port
    to_port     = var.redis_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Acceso Redis"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Salida permitida"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "elasticache-sg-${var.environment}"
    }
  )
}

resource "aws_elasticache_replication_group" "main" {
  replication_group_id       = "redis-${var.environment}-${random_id.redis_suffix.hex}"
  replication_group_description = "Redis cluster para cache de sesiones"

  engine               = "redis"
  engine_version      = var.redis_version
  node_type           = var.node_type
  number_cache_clusters = var.num_cache_nodes

  port                 = var.redis_port
  parameter_group_name = var.parameter_group_name
  subnet_group_name    = aws_elasticache_subnet_group.main.name
  security_group_ids   = [aws_security_group.elasticache.id]

  at_rest_encryption_enabled = var.enable_encryption
  transit_encryption_enabled = var.enable_encryption
  auth_token_enabled         = var.enable_encryption

  automatic_failover_enabled = var.num_cache_nodes > 1 ? true : false
  multi_az_enabled          = var.num_cache_nodes > 1 ? true : false

  snapshot_retention_limit   = var.snapshot_retention_days
  snapshot_window           = var.snapshot_window
  maintenance_window        = var.maintenance_window

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately         = var.apply_immediately

  log_delivery_configuration {
    destination      = aws_elasticache_cloudwatch_log_group.redis_slow.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }

  log_delivery_configuration {
    destination      = aws_elasticache_cloudwatch_log_group.redis_engine.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "redis-${var.environment}"
    }
  )
}

resource "aws_elasticache_cloudwatch_log_group" "redis_slow" {
  name              = "/aws/elasticache/redis/${var.environment}/slow-log"
  retention_in_days = var.log_retention_days

  tags = merge(
    var.common_tags,
    {
      Name = "redis-slow-log-${var.environment}"
    }
  )
}

resource "aws_elasticache_cloudwatch_log_group" "redis_engine" {
  name              = "/aws/elasticache/redis/${var.environment}/engine-log"
  retention_in_days = var.log_retention_days

  tags = merge(
    var.common_tags,
    {
      Name = "redis-engine-log-${var.environment}"
    }
  )
}

// === ARCHIVO: infra/modules/elasticache/outputs.tf ===
output "redis_endpoint" {
  description = "Endpoint primario del cluster Redis"
  value       = aws_elasticache_replication_group.main.primary_endpoint_address
}

output "redis_reader_endpoint" {
  description = "Endpoint de lectura del cluster Redis"
  value       = aws_elasticache_replication_group.main.reader_endpoint_address
}

output "redis_port" {
  description = "Puerto de Redis"
  value       = aws_elasticache_replication_group.main.port
}

output "redis_replication_group_id" {
  description = "ID del grupo de replicación"
  value       = aws_elasticache_replication_group.main.id
}

output "redis_arn" {
  description = "ARN del grupo de replicación"
  value       = aws_elasticache_replication_group.main.arn
}

output "redis_security_group_id" {
  description = "ID del security group de ElastiCache"
  value       = aws_security_group.elasticache.id
}

output "redis_cache_nodes" {
  description = "Información de los nodos del cluster"
  value       = aws_elasticache_replication_group.main.cache_nodes
}

// === ARCHIVO: infra/modules/s3/main.tf ===
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

// === ARCHIVO: infra/modules/s3/outputs.tf ===
# Salidas del módulo S3
# SUPERFICIE DE PRÁCTICA: definir los outputs necesarios

# TODO: Output con el ARN del bucket de imágenes
# Output: bucket_images_arn

# TODO: Output con el nombre del bucket de imágenes
# Output: bucket_images_name

# TODO: Output con el ARN del bucket de archivos temporales
# Output: bucket_temp_arn

# TODO: Output con el nombre del bucket de archivos temporales
# Output: bucket_temp_name

# TODO: Output con el ARN del bucket de logs
# Output: bucket_logs_arn

# TODO: Output con el nombre del bucket de logs
# Output: bucket_logs_name

// === ARCHIVO: infra/modules/iam/main.tf ===
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

// === ARCHIVO: infra/modules/iam/outputs.tf ===
output "ecs_task_execution_role_arn" {
  description = "ARN del rol de ejecución de tareas ECS"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_execution_role_name" {
  description = "Nombre del rol de ejecución de tareas ECS"
  value       = aws_iam_role.ecs_task_execution.name
}

output "ecs_task_role_arn" {
  description = "ARN del rol de tarea ECS"
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_task_role_name" {
  description = "Nombre del rol de tarea ECS"
  value       = aws_iam_role.ecs_task.name
}

// === ARCHIVO: infra/modules/alb/main.tf ===
resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(
    var.tags,
    {
      Name = var.alb_name
    }
  )
}

resource "aws_lb_target_group" "main" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = var.health_check_enabled
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    path                = var.health_check_path
    matcher             = var.health_check_matcher
  }

  tags = merge(
    var.tags,
    {
      Name = var.target_group_name
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_http_port
  protocol          = var.listener_http_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "https" {
  count             = var.listener_https_port != null ? 1 : 0
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_https_port
  protocol          = var.listener_https_protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

// === ARCHIVO: infra/modules/alb/outputs.tf ===
output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.main.arn
}

output "alb_arn_suffix" {
  description = "Sufijo del ARN del ALB"
  value       = aws_lb.main.arn_suffix
}

output "alb_dns_name" {
  description = "Nombre DNS del ALB"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB"
  value       = aws_lb.main.zone_id
}

output "alb_id" {
  description = "ID del ALB"
  value       = aws_lb.main.id
}

output "target_group_arn" {
  description = "ARN del Target Group"
  value       = aws_lb_target_group.main.arn
}

output "target_group_name" {
  description = "Nombre del Target Group"
  value       = aws_lb_target_group.main.name
}

output "listener_http_arn" {
  description = "ARN del listener HTTP"
  value       = aws_lb_listener.http.arn
}

output "listener_https_arn" {
  description = "ARN del listener HTTPS"
  value       = length(aws_lb_listener.https) > 0 ? aws_lb_listener.https[0].arn : null
}

// === ARCHIVO: infra/modules/efs/main.tf ===
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

// === ARCHIVO: infra/modules/efs/outputs.tf ===
# Salidas del módulo EFS
# Superficie de práctica: definir las salidas necesarias

output "efs_id" {
  description = "ID del sistema de archivos EFS"
  value       = aws_efs_file_system.this.id
}

output "efs_arn" {
  description = "ARN del sistema de archivos EFS"
  value       = aws_efs_file_system.this.arn
}

output "efs_dns_name" {
  description = "Nombre DNS del sistema de archivos EFS"
  value       = aws_efs_file_system.this.dns_name
}

output "mount_target_ids" {
  description = "IDs de los mount targets"
  value       = aws_efs_mount_target.this[*].id
}

output "mount_target_ips" {
  description = "IPs de los mount targets"
  value       = aws_efs_mount_target.this[*].ip_address
}

output "access_point_id" {
  description = "ID del access point"
  value       = aws_efs_access_point.this.id
}

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

// === ARCHIVO: infra/main.tf ===
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "pedidos-app"
      ManagedBy   = "terraform"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "ecs" {
  source = "./modules/ecs"

  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  public_subnet_ids     = module.vpc.public_subnet_ids
  ecs_cluster_name      = var.ecs_cluster_name
  container_image       = var.container_image
  container_port        = var.container_port
  desired_count         = var.desired_count
  max_count             = var.max_count
  min_count             = var.min_count
}

module "rds" {
  source = "./modules/rds"

  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnet_ids
  db_name             = var.db_name
  db_instance_class   = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_engine_version   = var.db_engine_version
}

module "elasticache" {
  source = "./modules/elasticache"

  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnet_ids
  node_type        = var.elasticache_node_type
  num_cache_nodes  = var.num_cache_nodes
  engine_version   = var.elasticache_engine_version
}

module "s3" {
  source = "./modules/s3"

  environment = var.environment
}

module "iam" {
  source = "./modules/iam"

  environment     = var.environment
  ecs_cluster_arn = module.ecs.ecs_cluster_arn
  ecs_task_role_arn = module.ecs.ecs_task_role_arn
}

module "alb" {
  source = "./modules/alb"

  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  target_group_arn    = module.ecs.target_group_arn
  alb_name            = var.alb_name
}

module "efs" {
  source = "./modules/efs"

  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnet_ids
  efs_throughput_mode = var.efs_throughput_mode
  efs_performance_mode = var.efs_performance_mode
}

// === ARCHIVO: infra/README.md ===
# Infraestructura Terraform - App de Pedidos

## Requisitos

- Terraform >= 1.10.0
- AWS CLI configurado con credenciales
- Cuenta de AWS con permisos para crear recursos

## Estructura del Proyecto

```
infra/
├── main.tf              # Punto de entrada - orquestación de módulos
├── versions.tf          # Definición de versiones de providers
├── variables.tf         # Variables globales del proyecto
├── outputs.tf           # Outputs globales
├── providers.tf         # Configuración de providers
├── terraform.tfvars     # Valores por defecto para variables
├── modules/
│   ├── vpc/             # Red virtual privada
│   ├── ecs/             # Cluster de contenedores
│   ├── rds/             # Base de datos PostgreSQL
│   ├── elasticache/     # Cache Redis
│   ├── s3/              # Almacenamiento de objetos
│   ├── iam/             # Roles y políticas
│   ├── alb/             # Balanceador de carga
│   └── efs/             # Sistema de archivos
├── environments/
│   └── dev/
│       └── terraform.tfvars
└── scripts/
    ├── deploy.sh        # Script de despliegue
    └── destroy.sh       # Script de destrucción
```

## Configuración Inicial

### 1. Inicializar Terraform

```bash
cd infra
terraform init
```

### 2. Validar configuración

```bash
terraform validate
terraform plan
```

### 3. Desplegar infraestructura

```bash
terraform apply
```

### 4. Destruir infraestructura

```bash
terraform destroy
```

## Variables Principales

| Variable | Descripción | Default |
|----------|-------------|---------|
| `aws_region` | Región de AWS | us-east-1 |
| `environment` | Entorno (dev/staging/prod) | dev |
| `vpc_cidr` | CIDR de la VPC | 10.0.0.0/16 |
| `ecs_cluster_name` | Nombre del cluster ECS | pedidos-cluster |
| `container_image` | Imagen del contenedor | - |
| `container_port` | Puerto del contenedor | 8080 |
| `db_name` | Nombre de la base de datos | pedidos_db |
| `db_instance_class` | Clase de instancia RDS | db.t3.micro |

## Arquitectura de Red

```
┌─────────────────────────────────────────────────────────┐
│                         VPC (10.0.0.0/16)               │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │              Public Subnets                      │   │
│  │  ┌─────────────┐    ┌─────────────┐             │   │
│  │  │   ALB       │    │   ALB       │             │   │
│  │  │  (az-a)     │    │  (az-b)     │             │   │
│  │  └──────┬──────┘    └──────┬──────┘             │   │
│  └─────────┼──────────────────┼────────────────────┘   │
│            │                  │                         │
│  ┌─────────┼──────────────────┼────────────────────┐   │
│  │         │    Private Subnets                    │   │
│  │  ┌──────┴──────┐    ┌──────┴──────┐             │   │
│  │  │  ECS Tasks  │    │  ECS Tasks  │             │   │
│  │  │  (az-a)     │    │  (az-b)     │             │   │
│  │  └──────┬──────┘    └──────┬──────┘             │   │
│  └─────────┼──────────────────┼────────────────────┘   │
│            │                  │                         │
│  ┌─────────┼──────────────────┼────────────────────┐   │
│  │         │    Data Layer                        │   │
│  │  ┌──────┴──────┐    ┌──────┴──────┐             │   │
│  │  │    RDS      │    │ ElastiCache │             │   │
│  │  │  (PostgreSQL│    │   (Redis)   │             │   │
│  │  └─────────────┘    └─────────────┘             │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

## Recursos Aprovisionados

- **VPC**: Red virtual con subnets públicas y privadas en 2 AZs
- **ECS**: Cluster de Fargate con auto-scaling
- **RDS**: Base de datos PostgreSQL Multi-AZ
- **ElastiCache**: Redis para caché de sesiones
- **ALB**: Balanceador de carga application
- **S3**: Bucket para uploads y estáticos
- **EFS**: Sistema de archivos compartido
- **IAM**: Roles para ECS y tareas

## Referencias

- [Documentación de Terraform](https://www.terraform.io/docs)
- [Provider AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [ECS Fargate](https://docs.aws.amazon.com/AmazonECS/latest/userguide/what-is-fargate.html)
- [RDS PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html)

// === ARCHIVO: infra/outputs.tf ===
# Outputs de la infraestructura - SUPERFICIE DE PRACTICA
# El estudiante debe implementar las salidas que exponen los recursos creados

# Output del VPC
output "vpc_id" {
  description = "ID del VPC creado"
  value       = module.vpc.vpc_id
}

# Output del Cluster ECS
output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = module.ecs.cluster_name
}

# Output de la base de datos RDS
output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.rds.endpoint
  sensitive   = true
}

# Output del Elasticache
output "elasticache_endpoint" {
  description = "Endpoint del cluster ElastiCache"
  value       = module.elasticache.endpoint
}

# Output del ALB
output "alb_dns_name" {
  description = "Nombre DNS del Application Load Balancer"
  value       = module.alb.dns_name
}

# Output del bucket S3
output "s3_bucket_name" {
  description = "Nombre del bucket S3 para artefactos"
  value       = module.s3.bucket_name
}

// === ARCHIVO: infra/terraform.tfvars ===
# Valores de variables para el entorno de producción
# Este archivo contiene la configuración específica del ambiente prod

# Configuración general del proyecto
project_name          = "pedidos-app"
environment           = "prod"
region                = "us-east-1"

# Configuración de VPC
vpc_cidr              = "10.0.0.0/16"
available_zones       = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets_cidr   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets_cidr  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
database_subnets_cidr = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

# Configuración de ECS
ecs_cluster_instance_type = "t3.medium"
ecs_cluster_desired_count = 3
ecs_cluster_min_size       = 2
ecs_cluster_max_size       = 6
ecs_cluster_autoscaling_enabled = true

# Configuración de RDS
rds_instance_class    = "db.t3.medium"
rds_allocated_storage = 100
rds_storage_type      = "gp3"
rds_engine            = "postgres"
rds_engine_version    = "15.4"
rds_db_name           = "pedidosdb"
rds_backup_retention_days = 7
rds_skip_final_snapshot = false
rds_final_snapshot_identifier = "pedidos-prod-final-snapshot"

# Configuración de ElastiCache
elasticache_node_type           = "cache.t3.medium"
elasticache_num_cache_nodes     = 2
elasticache_engine              = "redis"
elasticache_engine_version      = "7.0"
elasticache_port                = 6379
elasticache_parameter_group_name = "default.redis7.0"
elasticache_at_rest_encryption  = true
elasticache_transit_encryption  = true

# Configuración de S3
s3_bucket_versioning    = true
s3_enable_server_side_encryption = true
s3_server_side_encryption_algorithm = "AES256"

# Configuración de IAM
iam_role_policy_enabled = true
iam_enable_cloudwatch_logs = true

# Configuración de ALB
alb_enable_deletion_protection = true
alb_idle_timeout               = 60
alb_enable_cross_zone_load_balancing = true

# Configuración de EFS
efs_throughput_mode = "bursting"
efs_performance_mode = "generalPurpose"
efs_encrypted = true

# Tags obligatorios para todos los recursos
tags = {
  Environment = "prod"
  Project     = "pedidos-app"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Owner       = "plataforma"
}

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# Valores de variables para el entorno de desarrollo
# Configuración ligera para pruebas y desarrollo

# Configuración general del proyecto
project_name          = "pedidos-app"
environment           = "dev"
region                = "us-east-1"

# Configuración de VPC - rango más pequeño para dev
vpc_cidr              = "172.16.0.0/20"
available_zones       = ["us-east-1a", "us-east-1b"]
public_subnets_cidr   = ["172.16.1.0/24", "172.16.2.0/24"]
private_subnets_cidr  = ["172.16.11.0/24", "172.16.12.0/24"]
database_subnets_cidr = ["172.16.21.0/24", "172.16.22.0/24"]

# Configuración de ECS - instancias más pequeñas para dev
ecs_cluster_instance_type = "t3.small"
ecs_cluster_desired_count = 1
ecs_cluster_min_size       = 1
ecs_cluster_max_size       = 2
ecs_cluster_autoscaling_enabled = false

# Configuración de RDS - instancia mínima para dev
rds_instance_class    = "db.t3.micro"
rds_allocated_storage = 20
rds_storage_type      = "gp3"
rds_engine            = "postgres"
rds_engine_version    = "15.4"
rds_db_name           = "pedidosdb_dev"
rds_backup_retention_days = 1
rds_skip_final_snapshot = true
rds_final_snapshot_identifier = ""

# Configuración de ElastiCache - nodo único para dev
elasticache_node_type           = "cache.t3.micro"
elasticache_num_cache_nodes     = 1
elasticache_engine              = "redis"
elasticache_engine_version      = "7.0"
elasticache_port                = 6379
elasticache_parameter_group_name = "default.redis7.0"
elasticache_at_rest_encryption  = false
elasticache_transit_encryption  = false

# Configuración de S3
s3_bucket_versioning    = true
s3_enable_server_side_encryption = false
s3_server_side_encryption_algorithm = "AES256"

# Configuración de IAM
iam_role_policy_enabled = true
iam_enable_cloudwatch_logs = true

# Configuración de ALB
alb_enable_deletion_protection = false
alb_idle_timeout               = 60
alb_enable_cross_zone_load_balancing = true

# Configuración de EFS
efs_throughput_mode = "bursting"
efs_performance_mode = "generalPurpose"
efs_encrypted = false

# Tags obligatorios para todos los recursos en dev
tags = {
  Environment = "dev"
  Project     = "pedidos-app"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Owner       = "plataforma"
}

// === ARCHIVO: infra/scripts/deploy.sh ===
#!/bin/bash

set -euo pipefail

readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_VERSION="1.0.0"
readonly TERRAFORM_MIN_VERSION="1.0.0"
readonly AWS_CLI_MIN_VERSION="2.0.0"

declare WORKING_DIRECTORY="${WORKING_DIRECTORY:-.}"
declare AUTO_APPROVE="${AUTO_APPROVE:-false}"
declare VERBOSE="${VERBOSE:-false}"
declare PARALLELISM="${TERRAFORM_PARALLELISM:-10}"
declare BACKEND_CONFIG="${BACKEND_CONFIG:-}"
declare VAR_FILE="${VAR_FILE:-}"
declare TARGETS=()
declare PLAN_OUT_FILE=""
declare LOCK_TIMEOUT="${LOCK_TIMEOUT:-10m}"
declare COLOR_RESET='\033[0m'
declare COLOR_RED='\033[0;31m'
declare COLOR_GREEN='\033[0;32m'
declare COLOR_YELLOW='\033[0;33m'
declare COLOR_BLUE='\033[0;34m'
declare COLOR_BOLD='\033[1m'

function log_info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $*"
}

function log_success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $*"
}

function log_warning() {
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_RESET} $*"
}

function log_error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $*" >&2
}

function log_debug() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${COLOR_BOLD}[DEBUG]${COLOR_RESET} $*"
    fi
}

function print_banner() {
    echo -e "${COLOR_BOLD}"
    echo "╔══════════════════════════════════════════════════════════════════════╗"
    echo "║                    SCRIPT DE DESPLIEGUE TERRAFORM                     ║"
    echo "║                                                                      ║"
    echo "║  Este script ejecuta el ciclo completo de despliegue:               ║"
    echo "║  1. Validación de prerrequisitos                                     ║"
    echo "║  2. Inicialización de Terraform (terraform init)                   ║"
    echo "║  3. Planificación de cambios (terraform plan)                       ║"
    echo "║  4. Aplicación de cambios (terraform apply)                         ║"
    echo "╚══════════════════════════════════════════════════════════════════════╝"
    echo -e "${COLOR_RESET}"
}

function print_usage() {
    cat << EOF
Uso: $SCRIPT_NAME [OPCIONES]

Opciones:
  -h, --help                    Mostrar esta ayuda y salir
  -v, --version                 Mostrar versión del script y salir
  -d, --directory DIR           Directorio de trabajo (default: .)
  -a, --auto-approve            Aprobar automáticamente los cambios
  -V, --verbose                 Modo verbose (debug output)
  -p, --parallelism N           Nivel de paralelismo (default: 10)
  -b, --backend-config FILE     Archivo de configuración del backend
  -f, --var-file FILE           Archivo de variables adicional
  -t, --target RECURSO          Aplicar solo el recurso específico (puede repetirse)
  -o, --out FILE                Guardar plan en archivo
  -l, --lock-timeout DURACION   Timeout para locking de state (default: 10m)
  -e, --environment ENV         Entorno (dev/staging/prod)

Variables de entorno:
  WORKING_DIRECTORY     Directorio de trabajo (equivalente a -d)
  AUTO_APPROVE          Aprobación automática (equivalente a -a)
  VERBOSE               Modo verbose (equivalente a -V)
  TERRAFORM_PARALLELISM Nivel de paralelismo (equivalente a -p)

Ejemplos:
  $SCRIPT_NAME                                    # Ejecución interactiva
  $SCRIPT_NAME -a                                 # Ejecución con auto-aprobación
  $SCRIPT_NAME -e prod -f prod.tfvars            # Entorno de producción
  $SCRIPT_NAME -t aws_ecs_cluster.app            # Aplicar solo el cluster ECS
  $SCRIPT_NAME -o plan.out -a                    # Guardar plan y aplicar

EOF
}

function parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                print_usage
                exit 0
                ;;
            -v|--version)
                echo "$SCRIPT_NAME versión $SCRIPT_VERSION"
                exit 0
                ;;
            -d|--directory)
                WORKING_DIRECTORY="$2"
                shift 2
                ;;
            -a|--auto-approve)
                AUTO_APPROVE="true"
                shift
                ;;
            -V|--verbose)
                VERBOSE="true"
                shift
                ;;
            -p|--parallelism)
                PARALLELISM="$2"
                shift 2
                ;;
            -b|--backend-config)
                BACKEND_CONFIG="$2"
                shift 2
                ;;
            -f|--var-file)
                VAR_FILE="$2"
                shift 2
                ;;
            -t|--target)
                TARGETS+=("$2")
                shift 2
                ;;
            -o|--out)
                PLAN_OUT_FILE="$2"
                shift 2
                ;;
            -l|--lock-timeout)
                LOCK_TIMEOUT="$2"
                shift 2
                ;;
            -e|--environment)
                export TF_VAR_environment="$2"
                shift 2
                ;;
            -*)
                log_error "Opción desconocida: $1"
                print_usage
                exit 1
                ;;
            *)
                log_error "Argumento desconocido: $1"
                print_usage
                exit 1
                ;;
        esac
    done
}

function check_terraform_installed() {
    log_info "Verificando instalación de Terraform..."
    
    if ! command -v terraform &> /dev/null; then
        log_error "Terraform no está instalado"
        log_error "Por favor instala Terraform >= $TERRAFORM_MIN_VERSION"
        log_info "Guía de instalación: https://learn.hashicorp.com/tutorials/terraform/install-cli"
        exit 1
    fi
    
    local terraform_version
    terraform_version=$(terraform version -json 2>/dev/null | grep -o '"version": "[^"]*"' | cut -d'"' -f4 || terraform version 2>&1 | head -n1 | grep -oP '\d+\.\d+\.\d+')
    
    log_debug "Terraform version: $terraform_version"
    log_success "Terraform instalado: $terraform_version"
}

function check_aws_credentials() {
    log_info "Verificando credenciales de AWS..."
    
    if ! command -v aws &> /dev/null; then
        log_warning "AWS CLI no está instalado. Algunas funciones pueden no estar disponibles.
"
        return 0
    fi
    
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "Credenciales de AWS no configuradas o inválidas"
        log_error "Por favor configura tus credenciales con: aws configure"
        exit 1
    fi
    
    local identity
    identity=$(aws sts get-caller-identity 2>/dev/null | grep -o '"Arn": "[^"]*"' | cut -d'"' -f4)
    log_success "Credenciales de AWS configuradas: $identity"
}

function check_working_directory() {
    log_info "Verificando directorio de trabajo: $WORKING_DIRECTORY"
    
    if [[ ! -d "$WORKING_DIRECTORY" ]]; then
        log_error "El directorio no existe: $WORKING_DIRECTORY"
        exit 1
    fi
    
    if [[ ! -f "$WORKING_DIRECTORY/main.tf" ]]; then
        log_error "No se encontró main.tf en: $WORKING_DIRECTORY"
        log_error "Asegúrate de que el directorio contiene archivos de Terraform"
        exit 1
    fi
    
    log_success "Directorio de trabajo válido"
}

function terraform_init() {
    log_info "Inicializando Terraform..."
    
    local init_args=("-upgrade")
    
    if [[ -n "$BACKEND_CONFIG" ]]; then
        if [[ -f "$WORKING_DIRECTORY/$BACKEND_CONFIG" ]]; then
            init_args+=("-backend-config=$WORKING_DIRECTORY/$BACKEND_CONFIG")
            log_debug "Usando configuración de backend: $BACKEND_CONFIG"
        else
            log_warning "Archivo de backend no encontrado: $BACKEND_CONFIG"
        fi
    fi
    
    if [[ "$VERBOSE" == "true" ]]; then
        init_args+=("-verbose")
    fi
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    if ! terraform init "${init_args[@]}"; then
        log_error "Error al inicializar Terraform"
        exit 1
    fi
    
    log_success "Terraform inicializado correctamente"
}

function terraform_validate() {
    log_info "Validando configuración de Terraform..."
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    if ! terraform validate; then
        log_error "La configuración de Terraform no es válida"
        exit 1
    fi
    
    log_success "Configuración validada correctamente"
}

function terraform_plan() {
    log_info "Generando plan de despliegue..."
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    local plan_args=(
        "-out=$PLAN_OUT_FILE"
        "-parallelism=$PARALLELISM"
        "-lock-timeout=$LOCK_TIMEOUT"
        "-input=false"
    )
    
    if [[ -n "$VAR_FILE" ]]; then
        if [[ -f "$WORKING_DIRECTORY/$VAR_FILE" ]]; then
            plan_args+=("-var-file=$VAR_FILE")
            log_debug "Usando archivo de variables: $VAR_FILE"
        else
            log_warning "Archivo de variables no encontrado: $VAR_FILE"
        fi
    fi
    
    if [[ ${#TARGETS[@]} -gt 0 ]]; then
        for target in "${TARGETS[@]}"; do
            plan_args+=("-target=$target")
        done
        log_info "Aplicando solo a recursos específicos: ${TARGETS[*]}"
    fi
    
    if [[ "$VERBOSE" == "true" ]]; then
        plan_args+=("-verbose")
    fi
    
    if ! terraform plan "${plan_args[@]}"; then
        log_error "Error al generar el plan"
        exit 1
    fi
    
    if [[ -n "$PLAN_OUT_FILE" && -f "$PLAN_OUT_FILE" ]]; then
        log_success "Plan guardado en: $PLAN_OUT_FILE"
    fi
    
    terraform show -json "$PLAN_OUT_FILE" | grep -q '"changes"' && {
        local changes_count
        changes_count=$(terraform show -json "$PLAN_OUT_FILE" 2>/dev/null | grep -o '"action": "[^"]*"' | wc -l)
        log_info "Plan generado: $changes_count cambios detectados"
    }
}

function terraform_apply() {
    log_info "Aplicando cambios de infraestructura..."
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    local apply_args=(
        "-parallelism=$PARALLELISM"
        "-lock-timeout=$LOCK_TIMEOUT"
        "-input=false"
    )
    
    if [[ "$AUTO_APPROVE" == "true" ]]; then
        apply_args+=("-auto-approve")
    fi
    
    if [[ -n "$PLAN_OUT_FILE" && -f "$PLAN_OUT_FILE" ]]; then
        apply_args+=("$PLAN_OUT_FILE")
        log_info "Aplicando plan desde archivo: $PLAN_OUT_FILE"
    fi
    
    if ! terraform apply "${apply_args[@]}"; then
        log_error "Error al aplicar los cambios"
        exit 1
    fi
    
    log_success "Infraestructura desplegada correctamente"
}

function print_deployment_summary() {
    log_info "═══════════════════════════════════════════════════════════"
    log_info "                    RESUMEN DE DESPLIEGUE                    ""
    log_info "═══════════════════════════════════════════════════════════"
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    echo ""
    log_info "Recursos desplegados:"
    terraform state list 2>/dev/null | head -20 || echo "  (No hay recursos en el state)"
    
    echo ""
    log_info "Outputs del despliegue:"
    terraform output 2>/dev/null || echo "  (No hay outputs definidos)"
    
    echo ""
    log_success "Despliegue completado exitosamente"
}

function cleanup() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        log_error "El despliegue falló con código de salida: $exit_code"
        log_info "Revisa los logs anteriores para identificar el problema"
    fi
    return "$exit_code"
}

function main() {
    trap cleanup EXIT
    
    parse_arguments "$@"
    print_banner
    
    check_terraform_installed
    check_aws_credentials
    check_working_directory
    
    terraform_init
    terraform_validate
    terraform_plan
    terraform_apply
    
    print_deployment_summary
    
    log_success "═══════════════════════════════════════════════════════════"
    log_success "           DESPLIEGUE FINALIZADO EXITOSAMENTE               ""
    log_success "═══════════════════════════════════════════════════════════"
}

main "$@"

// === ARCHIVO: infra/scripts/destroy.sh ===
#!/bin/bash

set -euo pipefail

readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_VERSION="1.0.0"
readonly TERRAFORM_MIN_VERSION="1.0.0"

declare WORKING_DIRECTORY="${WORKING_DIRECTORY:-.}"
declare AUTO_APPROVE="${AUTO_APPROVE:-false}"
declare VERBOSE="${VERBOSE:-false}"
declare FORCE_DESTROY="${FORCE_DESTROY:-false}"
declare PARALLELISM="${TERRAFORM_PARALLELISM:-10}"
declare VAR_FILE="${VAR_FILE:-}"
declare TARGETS=()
declare LOCK_TIMEOUT="${LOCK_TIMEOUT:-10m}"
declare BACKUP_STATE="${BACKUP_STATE:-true}"
declare DESTROY_MODE="${DESTROY_MODE:-full}"
declare COLOR_RESET='\033[0m'
declare COLOR_RED='\033[0;31m'
declare COLOR_GREEN='\033[0;32m'
declare COLOR_YELLOW='\033[0;33m'
declare COLOR_BLUE='\033[0;34m'
declare COLOR_BOLD='\033[1m'
declare COLOR_BG_RED='\033[41m'

function log_info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $*"
}

function log_success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $*"
}

function log_warning() {
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_RESET} $*" >&2
}

function log_error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $*" >&2
}

function log_danger() {
    echo -e "${COLOR_BG_RED}${COLOR_BOLD}[PELIGRO]${COLOR_RESET} $*"
}

function log_debug() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${COLOR_BOLD}[DEBUG]${COLOR_RESET} $*"
    fi
}

function print_banner() {
    echo -e "${COLOR_BOLD}${COLOR_BG_RED}"
    echo "╔══════════════════════════════════════════════════════════════════════╗"
    echo "║                 SCRIPT DE DESTRUCCIÓN DE INFRAESTRUCTURA             ║"
    echo "║                                                                      ║"
    echo "║  ADVERTENCIA: Este script DESTRUIRÁ todos los recursos              ║"
    echo "║  aprovisionados por Terraform. Esta acción es IRREVERSIBLE.         ║"
    echo "║                                                                      ║"
    echo "║  El script ejecutará:                                               ║"
    echo "║  1. Validación de prerrequisitos                                    ║"
    echo "║  2. Inicialización de Terraform (terraform init)                   ║"
    echo "║  3. Planificación de destrucción (terraform plan -destroy)         ║"
    echo "║  4. Destrucción de recursos (terraform destroy)                    ║"
    echo "╚══════════════════════════════════════════════════════════════════════╝"
    echo -e "${COLOR_RESET}"
}

function print_usage() {
    cat << EOF
Uso: $SCRIPT_NAME [OPCIONES]

Opciones:
  -h, --help                    Mostrar esta ayuda y salir
  -v, --version                 Mostrar versión del script y salir
  -d, --directory DIR           Directorio de trabajo (default: .)
  -a, --auto-approve            Aprobar automáticamente la destrucción
  -V, --verbose                 Modo verbose (debug output)
  -f, --force                   Forzar destrucción sin confirmación
  -p, --parallelism N           Nivel de paralelismo (default: 10)
  -f, --var-file FILE           Archivo de variables adicional
  -t, --target RECURSO          Destruir solo el recurso específico (puede repetirse)
  -l, --lock-timeout DURACION   Timeout para locking de state (default: 10m)
  -e, --environment ENV         Entorno (dev/staging/prod)
  -m, --mode MODE               Modo de destrucción: full|target|import (default: full)
      --no-backup               No crear backup del state antes de destruir

Variables de entorno:
  WORKING_DIRECTORY     Directorio de trabajo (equivalente a -d)
  AUTO_APPROVE          Aprobación automática (equivalente a -a)
  VERBOSE               Modo verbose (equivalente a -V)
  FORCE_DESTROY         Forzar destrucción (equivalente a -f)
  TERRAFORM_PARALLELISM Nivel de paralelismo (equivalente a -p)
  DESTROY_MODE          Modo de destrucción

Ejemplos:
  $SCRIPT_NAME                                    # Ejecución interactiva
  $SCRIPT_NAME -a                                 # Destrucción con auto-aprobación
  $SCRIPT_NAME -e prod -f prod.tfvars            # Destruir entorno de producción
  $SCRIPT_NAME -t aws_ecs_cluster.app            # Destruir solo el cluster ECS
  $SCRIPT_NAME -m target -t module.rds           # Destruir solo el módulo RDS
  $SCRIPT_NAME --no-backup -a                    # Sin backup, auto-aprobado

PELIGRO: La destrucción de recursos es IRREVERSIBLE.
         Asegúrate de tener backups de datos importantes antes de proceder.

EOF
}

function parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                print_usage
                exit 0
                ;;
            -v|--version)
                echo "$SCRIPT_NAME versión $SCRIPT_VERSION"
                exit 0
                ;;
            -d|--directory)
                WORKING_DIRECTORY="$2"
                shift 2
                ;;
            -a|--auto-approve)
                AUTO_APPROVE="true"
                shift
                ;;
            -V|--verbose)
                VERBOSE="true"
                shift
                ;;
            -f|--force)
                FORCE_DESTROY="true"
                AUTO_APPROVE="true"
                shift
                ;;
            -p|--parallelism)
                PARALLELISM="$2"
                shift 2
                ;;
            -f|--var-file)
                VAR_FILE="$2"
                shift 2
                ;;
            -t|--target)
                TARGETS+=("$2")
                DESTROY_MODE="target"
                shift 2
                ;;
            -l|--lock-timeout)
                LOCK_TIMEOUT="$2"
                shift 2
                ;;
            -e|--environment)
                export TF_VAR_environment="$2"
                shift 2
                ;;
            -m|--mode)
                DESTROY_MODE="$2"
                shift 2
                ;;
            --no-backup)
                BACKUP_STATE="false"
                shift
                ;;
            -*)
                log_error "Opción desconocida: $1"
                print_usage
                exit 1
                ;;
            *)
                log_error "Argumento desconocido: $1"
                print_usage
                exit 1
                ;;
        esac
    done
}

function confirm_destruction() {
    if [[ "$AUTO_APPROVE" == "true" ]]; then
        log_warning "Modo de auto-aprobación activado. Se destruirán todos los recursos."
        return 0
    fi
    
    echo ""
    log_danger "═══════════════════════════════════════════════════════════"
    log_danger "  ATENCIÓN:Está a punto de DESTRUIR infraestructura de Terraform"
    log_danger "══════════════════════════════════════════════════════════="
    echo ""
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    local resource_count
    resource_count=$(terraform state list 2>/dev/null | wc -l || echo "0")
    
    if [[ "$resource_count" -gt 0 ]]; then
        log_warning "Recursos que serán destruidos: $resource_count"
        echo ""
        terraform state list 2>/dev/null | head -30
        if [[ "$resource_count" -gt 30 ]]; then
            echo "  ... y $((resource_count - 30)) más"
        fi
        echo ""
    fi
    
    read -p "¿Está seguro que desea continuar? Escriba 'DESTROY' para confirmar: " -r
    echo ""
    
    if [[ "$REPLY" != "DESTROY" ]]; then
        log_info "Operación cancelada por el usuario"
        exit 0
    fi
    
    log_warning "Confirmación recibida. Procediendo con la destrucción..."
}

function check_terraform_installed() {
    log_info "Verificando instalación de Terraform..."
    
    if ! command -v terraform &> /dev/null; then
        log_error "Terraform no está instalado"
        log_error "Por favor instala Terraform >= $TERRAFORM_MIN_VERSION"
        exit 1
    fi
    
    local terraform_version
    terraform_version=$(terraform version -json 2>/dev/null | grep -o '"version": "[^"]*"' | cut -d'"' -f4 || terraform version 2>&1 | head -n1 | grep -oP '\d+\.\d+\.\d+')
    
    log_debug "Terraform version: $terraform_version"
    log_success "Terraform instalado: $terraform_version"
}

function check_working_directory() {
    log_info "Verificando directorio de trabajo: $WORKING_DIRECTORY"
    
    if [[ ! -d "$WORKING_DIRECTORY" ]]; then
        log_error "El directorio no existe: $WORKING_DIRECTORY"
        exit 1
    fi
    
    if [[ ! -f "$WORKING_DIRECTORY/main.tf" ]]; then
        log_error "No se encontró main.tf en: $WORKING_DIRECTORY"
        exit 1
    fi
    
    log_success "Directorio de trabajo válido"
}

function check_state_exists() {
    cd "$WORKING_DIRECTORY" || exit 1
    
    if [[ ! -f ".terraform/terraform.tfstate" ]] && ! terraform state pull &>/dev/null; then
        log_warning "No existe estado de Terraform"
        log_info "No hay infraestructura que destruir"
        exit 0
    fi
    
    local resource_count
    resource_count=$(terraform state list 2>/dev/null | wc -l || echo "0")
    
    if [[ "$resource_count" -eq 0 ]]; then
        log_info "El state está vacío. No hay recursos que destruir."
        exit 0
    fi
    
    log_info "Recursos en el state: $resource_count"
}

function backup_state() {
    if [[ "$BACKUP_STATE" != "true" ]]; then
        log_info "Backup de state desactivado"
        return 0
    fi
    
    log_info "Creando backup del state..."
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    local backup_timestamp
    backup_timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_filename="terraform_backup_${backup_timestamp}.tfstate"
    
    if terraform state pull > "$backup_filename" 2>/dev/null; then
        log_success "Backup creado: $backup_filename"
        log_info "Puedes restaurarlo con: terraform state push $backup_filename"
    else
        log_warning "No se pudo crear el backup del state"
    fi
}

function terraform_init() {
    log_info "Inicializando Terraform..."
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    local init_args=("-upgrade")
    
    if [[ "$VERBOSE" == "true" ]]; then
        init_args+=("-verbose")
    fi
    
    if ! terraform init "${init_args[@]}"; then
        log_error "Error al inicializar Terraform"
        exit 1
    fi
    
    log_success "Terraform inicializado correctamente"
}

function terraform_destroy_plan() {
    log_info "Generando plan de destrucción..."
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    local plan_args=(
        "-destroy"
        "-out=destroy_plan.tfplan"
        "-parallelism=$PARALLELISM"
        "-lock-timeout=$LOCK_TIMEOUT"
        "-input=false"
    )
    
    if [[ -n "$VAR_FILE" ]]; then
        if [[ -f "$WORKING_DIRECTORY/$VAR_FILE" ]]; then
            plan_args+=("-var-file=$VAR_FILE")
            log_debug "Usando archivo de variables: $VAR_FILE"
        else
            log_warning "Archivo de variables no encontrado: $VAR_FILE"
        fi
    fi
    
    if [[ ${#TARGETS[@]} -gt 0 ]]; then
        for target in "${TARGETS[@]}"; do
            plan_args+=("-target=$target")
        done
        log_info "Destruyendo recursos específicos: ${TARGETS[*]}"
    fi
    
    if [[ "$VERBOSE" == "true" ]]; then
        plan_args+=("-verbose")
    fi
    
    if ! terraform plan "${plan_args[@]}"; then
        log_error "Error al generar el plan de destrucción"
        exit 1
    fi
    
    if [[ -f "destroy_plan.tfplan" ]]; then
        log_success "Plan de destrucción generado"
    fi
}

function terraform_destroy() {
    log_danger "DESTRUYENDO infraestructura..."
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    local destroy_args=(
        "-parallelism=$PARALLELISM"
        "-lock-timeout=$LOCK_TIMEOUT"
        "-input=false"
    )
    
    if [[ "$AUTO_APPROVE" == "true" ]]; then
        destroy_args+=("-auto-approve")
    fi
    
    if [[ -f "destroy_plan.tfplan" ]]; then
        destroy_args+=("destroy_plan.tfplan")
    fi
    
    if ! terraform destroy "${destroy_args[@]}"; then
        log_error "Error al destruir la infraestructura"
        exit 1
    fi
    
    log_success "Infraestructura destruida correctamente"
}

function cleanup_temp_files() {
    log_debug "Limpiando archivos temporales..."
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    if [[ -f "destroy_plan.tfplan" ]]; then
        rm -f destroy_plan.tfplan
        log_debug "Plan de destrucción eliminado"
    fi
}

function print_destruction_summary() {
    log_info "═══════════════════════════════════════════════════════════"
    log_info "                   RESUMEN DE DESTRUCCIÓN                    ""
    log_info "═══════════════════════════════════════════════════════════"
    
    cd "$WORKING_DIRECTORY" || exit 1
    
    local resource_count
    resource_count=$(terraform state list 2>/dev/null | wc -l || echo "0")
    
    if [[ "$resource_count" -eq 0 ]]; then
        log_success "Todos los recursos han sido eliminados"
    else
        log_warning "Recursos restantes en el state: $resource_count"
        log_info "Recursos restantes:"
        terraform state list 2>/dev/null || true
    fi
    
    echo ""
    log_success "═══════════════════════════════════════════════════════════"
    log_success "           DESTRUCCIÓN COMPLETADA EXITOSAMENTE             ""
    log_success "═══════════════════════════════════════════════════════════"
    
    if [[ -f "terraform_backup_"*.tfstate ]]; then
        log_info "Backups del state disponibles en el directorio"
    fi
}

function main() {
    print_banner
    
    parse_arguments "$@"
    
    check_terraform_installed
    check_working_directory
    check_state_exists
    confirm_destruction
    
    backup_state
    terraform_init
    terraform_destroy_plan
    terraform_destroy
    
    cleanup_temp_files
    print_destruction_summary
}

main "$@"

// === ARCHIVO: client/pubspec.yaml ===
name: pedidos_app
description: Aplicación móvil de pedidos con backend desplegado mediante Terraform
version: 1.0.0+1
environment:
  sdk: '>=3.3.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: 8.1.6
  dio: 5.7.0
  equatable: 2.0.7
  get_it: 8.0.3
  dartz: 0.10.1
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: 9.1.7
  mocktail: 1.0.4
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/
    - assets/images/

// === ARCHIVO: client/lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pedidos_app/core/network/api_client.dart';
import 'package:pedidos_app/data/repositories/order_repository_impl.dart';
import 'package:pedidos_app/data/repositories/product_repository_impl.dart';
import 'package:pedidos_app/domain/repositories/order_repository.dart';
import 'package:pedidos_app/domain/repositories/product_repository.dart';
import 'package:pedidos_app/presentation/blocs/order/order_bloc.dart';
import 'package:pedidos_app/presentation/blocs/product/product_bloc.dart';
import 'package:pedidos_app/presentation/screens/orders_screen.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Network
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Repositories
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: getIt()),
  );

  // BLoCs
  getIt.registerFactory<OrderBloc>(
    () => OrderBloc(orderRepository: getIt()),
  );
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(productRepository: getIt()),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<OrderBloc>()..add(FetchOrders())),
        BlocProvider(create: (_) => getIt<ProductBloc>()..add(FetchProducts())),
      ],
      child: MaterialApp(
        title: 'Pedidos App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const OrdersScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// === ARCHIVO: client/lib/core/constants/api_constants.dart ===
package pedidos_app.core.constants;

/// Constantes para la configuración de la API del backend de pedidos.
/// Incluye URLs base, endpoints y configuraciones de timeout y headers.
class ApiConstants {
  /// URL base del backend de pedidos
  static const String baseUrl = 'http://api.pedidos.example.com';

  /// Timeout para conexiones (en milisegundos)
  static const int connectTimeout = 5000;

  /// Timeout para recepción de datos (en milisegundos)
  static const int receiveTimeout = 10000;

  /// Headers comunes para todas las peticiones
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Endpoints de la API
  static const String ordersEndpoint = '/orders';
  static const String productsEndpoint = '/products';

  /// Constructor privado para evitar instanciación
  ApiConstants._();

  /// Valida que la URL base no esté vacía y termine con '/'
  static String get validatedBaseUrl {
    if (baseUrl.isEmpty) {
      throw const FormatException('La URL base no puede estar vacía');
    }
    return baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
  }

  /// Construye la URL completa para un endpoint dado
  static String buildUrl(String endpoint) {
    if (endpoint.isEmpty) {
      throw const FormatException('El endpoint no puede estar vacío');
    }
    return '${validatedBaseUrl}${endpoint.startsWith('/') ? endpoint.substring(1) : endpoint}';
  }

  /// Construye la URL para obtener un pedido por ID
  static String buildOrderByIdUrl(String id) {
    if (id.isEmpty) {
      throw const FormatException('El ID del pedido no puede estar vacío');
    }
    return '${buildUrl(ordersEndpoint)}/$id';
  }
}

// === ARCHIVO: client/lib/core/errors/exceptions.dart ===
package pedidos_app.core.errors;

/// Excepciones personalizadas para manejo de errores en la aplicación.
/// Cada excepción representa un tipo específico de error que puede ocurrir
/// durante la ejecución de la app, especialmente en operaciones de red y parsing.
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;

  const ServerException({
    this.message = 'Error en el servidor',
    this.statusCode,
    this.errorCode,
  });

  @override
  String toString() {
    return 'ServerException{message: $message, statusCode: $statusCode, errorCode: $errorCode}';
  }
}

class NetworkException implements Exception {
  final String message;
  final String? underlyingError;

  const NetworkException({
    this.message = 'Error de conexión',
    this.underlyingError,
  });

  @override
  String toString() {
    return 'NetworkException{message: $message, underlyingError: $underlyingError}';
  }
}

class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Error en caché'});

  @override
  String toString() => 'CacheException{message: $message}';
}

class ParseException implements Exception {
  final String message;
  final dynamic source;
  final StackTrace? stackTrace;

  const ParseException({
    this.message = 'Error al parsear datos',
    this.source,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'ParseException{message: $message, source: $source}';
  }
}

class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException({this.message = 'Error de autenticación'});

  @override
  String toString() => 'AuthenticationException{message: $message}';
}

/// Excepción para cuando se intenta acceder a un recurso offline
/// pero no hay datos en caché disponibles
class OfflineException implements Exception {
  final String message;

  const OfflineException({
    this.message = 'No hay conexión y no hay datos en caché disponibles',
  });

  @override
  String toString() => 'OfflineException{message: $message}';
}

// === ARCHIVO: client/lib/core/errors/failures.dart ===
package pedidos_app.core.errors;

import 'package:equatable/equatable.dart';

/// Clases para representar fallos en la aplicación usando el patrón Either.
/// Cada Failure corresponde a un tipo de error específico que puede ser manejado
/// de manera tipada en la capa de presentación.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  final String? errorCode;

  const ServerFailure({
    required String message,
    this.statusCode,
    this.errorCode,
  }) : super(message);

  @override
  List<Object?> get props => [message, statusCode, errorCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Error de conexión'})
      : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Error en caché'}) : super(message);
}

class ParseFailure extends Failure {
  const ParseFailure({String message = 'Error al parsear datos'})
      : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({String message = 'Error de autenticación'})
      : super(message);
}

class OfflineFailure extends Failure {
  const OfflineFailure({
    String message = 'No hay conexión y no hay datos en caché disponibles',
  }) : super(message);
}

/// Función de extensión para convertir excepciones en Failures
extension ExceptionToFailure on Exception {
  Failure toFailure() {
    if (this is ServerException) {
      final e = this as ServerException;
      return ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      );
    } else if (this is NetworkException) {
      return NetworkFailure(message: (this as NetworkException).message);
    } else if (this is CacheException) {
      return CacheFailure(message: (this as CacheException).message);
    } else if (this is ParseException) {
      return ParseFailure(message: (this as ParseException).message);
    } else if (this is AuthenticationException) {
      return AuthenticationFailure(message: (this as AuthenticationException).message);
    } else if (this is OfflineException) {
      return OfflineFailure(message: (this as OfflineException).message);
    } else {
      return Failure('Error desconocido');
    }
  }
}

// === ARCHIVO: client/lib/core/network/api_client.dart ===
package pedidos_app.core.network;

import 'package:dio/dio.dart';
import 'package:pedidos_app/core/constants/api_constants.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';

class ApiClient {
  final Dio _dio;
  final String _baseUrl;
  final int _connectTimeout;
  final int _receiveTimeout;

  ApiClient({
    Dio? dio,
    String? baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
  })  : _dio = dio ?? Dio(),
        _baseUrl = baseUrl ?? ApiConstants.baseUrl,
        _connectTimeout = connectTimeout ?? ApiConstants.connectTimeout,
        _receiveTimeout = receiveTimeout ?? ApiConstants.receiveTimeout {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: Duration(milliseconds: _connectTimeout),
      receiveTimeout: Duration(milliseconds: _receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.addAll([
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.ordersEndpoint);
      final response = await _dio.get(url);
      return _parseListResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> getOrderById(String id) async {
    try {
      final url = ApiConstants.buildOrderByIdUrl(id);
      final response = await _dio.get(url);
      return _parseMapResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.ordersEndpoint);
      final response = await _dio.post(url, data: orderData);
      return _parseMapResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.productsEndpoint);
      final response = await _dio.get(url);
      return _parseListResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  List<Map<String, dynamic>> _parseListResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      throw ParseException(
        message: 'Expected list response but got ${data.runtimeType}',
        source: data,
      );
    }
    throw ServerException(
      message: 'Unexpected status code: ${response.statusCode}',
      statusCode: response.statusCode,
    );
  }

  Map<String, dynamic> _parseMapResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      throw ParseException(
        message: 'Expected map response but got ${data.runtimeType}',
        source: data,
      );
    }
    throw ServerException(
      message: 'Unexpected status code: ${response.statusCode}',
      statusCode: response.statusCode,
    );
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timeout. Please check your internet connection.',
          underlyingError: error.message,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection. Please check your network settings.',
          underlyingError: error.message,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        String message = 'Server error occurred';
        String? errorCode;

        if (data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? message;
          errorCode = data['code'] ?? data['errorCode'];
        }

        if (statusCode == 401 || statusCode == 403) {
          return AuthenticationException(message: message);
        }

        return ServerException(
          message: message,
          statusCode: statusCode,
          errorCode: errorCode,
        );
      case DioExceptionType.cancel:
        return ServerException(
          message: 'Request was cancelled',
          statusCode: null,
        );
      default:
        return NetworkException(
          message: 'An unexpected network error occurred',
          underlyingError: error.message,
        );
    }
  }

  Dio get dio => _dio;
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('┌─────────────────────────────────────────────────────────────');
    print('│ REQUEST: ${options.method} ${options.path}');
    print('│ Base URL: ${options.baseUrl}');
    if (options.queryParameters.isNotEmpty) {
      print('│ Query Params: ${options.queryParameters}');
    }
    if (options.data != null) {
      print('│ Body: ${options.data}');
    }
    print('└─────────────────────────────────────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('┌─────────────────────────────────────────────────────────────');
    print('│ RESPONSE: ${response.statusCode} ${response.requestOptions.path}');
    print('│ Data: ${response.data}');
    print('└─────────────────────────────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('┌─────────────────────────────────────────────────────────────');
    print('│ ERROR: ${err.type}');
    print('│ Message: ${err.message}');
    if (err.response != null) {
      print('│ Status Code: ${err.response?.statusCode}');
      print('│ Response Data: ${err.response?.data}');
    }
    print('└─────────────────────────────────────────────────────────────');
    handler.next(err);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 429) {
      print('Rate limit exceeded. Consider adding retry logic.');
    }
    handler.next(err);
  }
}

// === ARCHIVO: client/lib/domain/entities/order.dart ===
package pedidos_app.domain.entities;

import 'package:equatable/equatable.dart';
import 'order_item.dart';

/// Entidad de dominio que representa un pedido en el sistema.
///
/// Esta clase encapsula toda la información relevante de un pedido,
/// incluyendo su identificador único, estado actual, items solicitados,
/// información del cliente, totales y fechas importantes.
///
/// La entidad es inmutable y utiliza [Equatable] para permitir
/// comparaciones por valor, lo cual es esencial para el correcto
/// funcionamiento del sistema de estado con BLoC.
class Order extends Equatable {
  /// Identificador único del pedido.
  final String id;

  /// Identificador del cliente que realizó el pedido.
  final String customerId;

  /// Nombre del cliente para display.
  final String customerName;

  /// Correo electrónico del cliente.
  final String? customerEmail;

  /// Teléfono de contacto del cliente.
  final String? customerPhone;

  /// Lista de items incluidos en el pedido.
  final List<OrderItem> items;

  /// Subtotal del pedido sin impuestos ni descuentos.
  final double subtotal;

  /// Monto del impuesto aplicado.
  final double taxAmount;

  /// Monto de descuento aplicado, si existe.
  final double discountAmount;

  /// Total final del pedido incluyendo todos los cargos.
  final double totalAmount;

  /// Estado actual del pedido en el sistema.
  final OrderStatus status;

  /// Fecha y hora en que se creó el pedido.
  final DateTime createdAt;

  /// Fecha y hora de la última actualización del pedido.
  final DateTime updatedAt;

  /// Dirección de entrega del pedido.
  final String? deliveryAddress;

  /// Notas adicionales proporcionadas por el cliente.
  final String? notes;

  /// Método de pago seleccionado.
  final PaymentMethod paymentMethod;

  /// Indica si el pedido ha sido pagado.
  final bool isPaid;

  /// Identificador de la transacción de pago, si aplica.
  final String? paymentTransactionId;

  /// Constructor completo de la entidad Order.
  ///
  /// Todos los campos son requeridos excepto aquellos marcados como opcionales.
  const Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    this.customerEmail,
    this.customerPhone,
    required this.items,
    required this.subtotal,
    required this.taxAmount,
    this.discountAmount = 0.0,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deliveryAddress,
    this.notes,
    required this.paymentMethod,
    this.isPaid = false,
    this.paymentTransactionId,
  });

  /// Retorna el número total de items en el pedido.
  ///
  /// Suma las cantidades de cada [OrderItem] para obtener
  /// la cantidad total de productos solicitados.
  int get totalItems {
    if (items.isEmpty) return 0;
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  /// Verifica si el pedido puede ser cancelado.
  ///
  /// Un pedido solo puede cancelarse si su estado actual
  /// es [OrderStatus.pending] o [OrderStatus.confirmed].
  bool get canCancel {
    return status == OrderStatus.pending ||
        status == OrderStatus.confirmed;
  }

  /// Verifica si el pedido puede ser modificado.
  ///
  /// Un pedido puede modificarse únicamente si está en estado
  /// [OrderStatus.pending], permitiendo agregar o quitar items.
  bool get canModify {
    return status == OrderStatus.pending;
  }

  /// Verifica si el pedido está en un estado activo.
  ///
  /// Un pedido se considera activo cuando no ha sido
  /// completado, cancelado ni rechazado.
  bool get isActive {
    return status != OrderStatus.completed &&
        status != OrderStatus.cancelled &&
        status != OrderStatus.rejected;
  }

  /// Crea una copia de la orden con los campos actualizados.
  ///
  /// Utilizado para crear nuevas versiones de la orden
  /// cuando se modifican atributos específicos.
  Order copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    List<OrderItem>? items,
    double? subtotal,
    double? taxAmount,
    double? discountAmount,
    double? totalAmount,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deliveryAddress,
    String? notes,
    PaymentMethod? paymentMethod,
    bool? isPaid,
    String? paymentTransactionId,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      paymentTransactionId: paymentTransactionId ?? this.paymentTransactionId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        customerEmail,
        customerPhone,
        items,
        subtotal,
        taxAmount,
        discountAmount,
        totalAmount,
        status,
        createdAt,
        updatedAt,
        deliveryAddress,
        notes,
        paymentMethod,
        isPaid,
        paymentTransactionId,
      ];
}

/// Enumeración que representa los posibles estados de un pedido.
///
/// Cada estado representa una etapa en el ciclo de vida del pedido,
/// desde su creación hasta su entrega o cancelación.
enum OrderStatus {
  /// Pedido creado, esperando confirmación del sistema.
  pending,

  /// Pedido confirmado y preparado para procesamiento.
  confirmed,

  /// Pedido en proceso de preparación.
  preparing,

  /// Pedido listo para entrega o recolección.
  ready,

  /// Pedido en tránsito hacia el cliente.
  inTransit,

  /// Pedido entregado exitosamente.
  completed,

  /// Pedido cancelado por el cliente o sistema.
  cancelled,

  /// Pedido rechazado por el proveedor.
  rejected,
}

/// Extensión que añade funcionalidad adicional a [OrderStatus].
///
/// Proporciona métodos de utilidad para trabajar con
/// los estados de manera más expresiva.
extension OrderStatusExtension on OrderStatus {
  /// Retorna el nombre legible del estado para display en UI.
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.preparing:
        return 'Preparando';
      case OrderStatus.ready:
        return 'Listo';
      case OrderStatus.inTransit:
        return 'En camino';
      case OrderStatus.completed:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
      case OrderStatus.rejected:
        return 'Rechazado';
    }
  }

  /// Indica si el estado representa un estado terminal.
  ///
  /// Los estados terminales no permiten transiciones adicionales.
  bool get isTerminal {
    return this == OrderStatus.completed ||
        this == OrderStatus.cancelled ||
        this == OrderStatus.rejected;
  }

  /// Indica si el estado permite modificaciones en el pedido.
  bool get allowsModification {
    return this == OrderStatus.pending;
  }
}

/// Enumeración que representa los métodos de pago disponibles.
enum PaymentMethod {
  /// Pago en efectivo contra entrega.
  cashOnDelivery,

  /// Pago con tarjeta de crédito o débito.
  card,

  /// Pago a través de transferencia bancaria.
  bankTransfer,

  /// Pago mediante billetera digital.
  digitalWallet,
}

/// Extensión que añade funcionalidad adicional a [PaymentMethod].
extension PaymentMethodExtension on PaymentMethod {
  /// Retorna el nombre legible del método de pago.
  String get displayName {
    switch (this) {
      case PaymentMethod.cashOnDelivery:
        return 'Efectivo contra entrega';
      case PaymentMethod.card:
        return 'Tarjeta';
      case PaymentMethod.bankTransfer:
        return 'Transferencia bancaria';
      case PaymentMethod.digitalWallet:
        return 'Billetera digital';
    }
  }
}

// === ARCHIVO: client/lib/domain/entities/order_item.dart ===
package pedidos_app.domain.entities;

import 'package:equatable/equatable.dart';

/// Entidad de dominio que representa un item individual dentro de un pedido.
///
/// Cada [OrderItem] corresponde a un producto específico solicitado
/// en un pedido, incluyendo la cantidad, precio unitario y cálculos
/// derivados como el subtotal.
class OrderItem extends Equatable {
  /// Identificador único del item en el pedido.
  final String id;

  /// Identificador del producto asociado.
  final String productId;

  /// Nombre del producto al momento de realizar el pedido.
  final String productName;

  /// Descripción adicional del producto.
  final String? productDescription;

  /// URL de la imagen del producto.
  final String? productImageUrl;

  /// Cantidad solicitada del producto.
  final int quantity;

  /// Precio unitario del producto en el momento del pedido.
  final double unitPrice;

  /// Porcentaje de descuento aplicado a este item, si existe.
  final double discountPercentage;

  /// Notas especiales para este item específicas del cliente.
  final String? specialInstructions;

  /// Constructor completo de la entidad OrderItem.
  ///
  /// [quantity] debe ser mayor a 0 y [unitPrice] no puede ser negativo.
  const OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    this.productDescription,
    this.productImageUrl,
    required this.quantity,
    required this.unitPrice,
    this.discountPercentage = 0.0,
    this.specialInstructions,
  });

  /// Calcula el precio unitario después de aplicar el descuento.
  ///
  /// Retorna el precio con el descuento ya calculado,
  /// permitiendo obtener el valor real a pagar por unidad.
  double get discountedUnitPrice {
    if (discountPercentage <= 0) return unitPrice;
    final discount = unitPrice * (discountPercentage / 100);
    return unitPrice - discount;
  }

  /// Calcula el subtotal del item sin aplicar descuentos.
  ///
  /// Es el resultado de multiplicar la cantidad por el precio
  /// unitario original, antes de descuentos.
  double get rawSubtotal {
    return quantity * unitPrice;
  }

  /// Calcula el subtotal del item con descuentos aplicados.
  ///
  /// Es el resultado de multiplicar la cantidad por el precio
  /// unitario con descuento ya calculado.
  double get subtotal {
    return quantity * discountedUnitPrice;
  }

  /// Calcula el monto total de descuento aplicado a este item.
  ///
  /// Retorna la diferencia entre el subtotal sin descuento
  /// y el subtotal con descuento.
  double get discountAmount {
    return rawSubtotal - subtotal;
  }

  /// Verifica si este item tiene algún descuento aplicado.
  bool get hasDiscount => discountPercentage > 0;

  /// Verifica si la cantidad solicitada está disponible.
  ///
  /// Este método será implementado con la lógica de validación
  /// contra el stock disponible del producto.
  bool isQuantityValid(int availableStock) {
    return quantity > 0 && quantity <= availableStock;
  }

  /// Crea una copia del item con los campos actualizados.
  OrderItem copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productDescription,
    String? productImageUrl,
    int? quantity,
    double? unitPrice,
    double? discountPercentage,
    String? specialInstructions,
  }) {
    return OrderItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productName,
        productDescription,
        productImageUrl,
        quantity,
        unitPrice,
        discountPercentage,
        specialInstructions,
      ];
}

// === ARCHIVO: client/lib/domain/entities/product.dart ===
package pedidos_app.domain.entities;

import 'package:equatable/equatable.dart';

/// Entidad de dominio que representa un producto disponible en el sistema.
///
/// Un producto es cualquier artículo que puede ser incluido en un pedido.
/// La entidad contiene toda la información relevante para la visualización
/// en el catálogo y para el procesamiento del pedido.
class Product extends Equatable {
  /// Identificador único del producto.
  final String id;

  /// Nombre del producto.
  final String name;

  /// Descripción detallada del producto.
  final String description;

  /// Precio base del producto.
  final double price;

  /// Categoría a la que pertenece el producto.
  final String category;

  /// URL de la imagen principal del producto.
  final String? imageUrl;

  /// Lista de URLs de imágenes adicionales del producto.
  final List<String> additionalImages;

  /// Indica si el producto está disponible para pedidos.
  final bool isAvailable;

  /// Cantidad actual en inventario.
  final int stockQuantity;

  /// Stock mínimo que activa alerta de reposición.
  final int? minimumStockThreshold;

  /// Código SKU del producto para gestión de inventario.
  final String? sku;

  /// Código de barras del producto.
  final String? barcode;

  /// Peso del producto en kilogramos.
  final double? weight;

  /// Dimensiones del producto (alto, ancho, profundidad) en centímetros.
  final ProductDimensions? dimensions;

  /// Fecha de creación del producto en el sistema.
  final DateTime createdAt;

  /// Fecha de la última actualización del producto.
  final DateTime updatedAt;

  /// Indica si el producto está destacado en el catálogo.
  final bool isFeatured;

  /// Valoración promedio del producto basada en reseñas.
  final double? averageRating;

  /// Número total de reseñas del producto.
  final int reviewCount;

  /// Etiquetas asociadas al producto para búsqueda y filtros.
  final List<String> tags;

  /// Constructor completo de la entidad Product.
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
    this.additionalImages = const [],
    this.isAvailable = true,
    required this.stockQuantity,
    this.minimumStockThreshold,
    this.sku,
    this.barcode,
    this.weight,
    this.dimensions,
    required this.createdAt,
    required this.updatedAt,
    this.isFeatured = false,
    this.averageRating,
    this.reviewCount = 0,
    this.tags = const [],
  });

  /// Verifica si el producto tiene stock disponible.
  ///
  /// Un producto se considera disponible en stock cuando
  /// su cantidad es mayor a cero y está marcado como disponible.
  bool get hasStock => stockQuantity > 0 && isAvailable;

  /// Verifica si el stock está bajo el umbral mínimo.
  ///
  /// Activa una alerta cuando la cantidad en stock es menor
  /// o igual al umbral configurado, indicando necesidad de reposición.
  bool get isLowStock {
    if (minimumStockThreshold == null) return false;
    return stockQuantity <= minimumStockThreshold!;
  }

  /// Verifica si el producto está agotado.
  ///
  /// Un producto está agotado cuando su stock es cero
  /// o no está marcado como disponible.
  bool get isOutOfStock => stockQuantity <= 0 || !isAvailable;

  /// Retorna el precio formateado como cadena.
  ///
  /// Convierte el valor numérico a formato monetario
  /// con dos decimales.
  String get formattedPrice {
    return '\$${price.toStringAsFixed(2)}';
  }

  /// Verifica si el producto tiene imágenes adicionales.
  bool get hasAdditionalImages => additionalImages.isNotEmpty;

  /// Verifica si el producto tiene reseñas.
  bool get hasReviews => reviewCount > 0;

  /// Verifica si el producto puede agregarse al carrito con la cantidad solicitada.
  bool canAddToCart(int requestedQuantity) {
    return isAvailable && stockQuantity >= requestedQuantity;
  }

  /// Crea una copia del producto con los campos actualizados.
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? imageUrl,
    List<String>? additionalImages,
    bool? isAvailable,
    int? stockQuantity,
    int? minimumStockThreshold,
    String? sku,
    String? barcode,
    double? weight,
    ProductDimensions? dimensions,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFeatured,
    double? averageRating,
    int? reviewCount,
    List<String>? tags,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      additionalImages: additionalImages ?? this.additionalImages,
      isAvailable: isAvailable ?? this.isAvailable,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minimumStockThreshold: minimumStockThreshold ?? this.minimumStockThreshold,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      weight: weight ?? this.weight,
      dimensions: dimensions ?? this.dimensions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFeatured: isFeatured ?? this.isFeatured,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        category,
        imageUrl,
        additionalImages,
        isAvailable,
        stockQuantity,
        minimumStockThreshold,
        sku,
        barcode,
        weight,
        dimensions,
        createdAt,
        updatedAt,
        isFeatured,
        averageRating,
        reviewCount,
        tags,
      ];
}

/// Entidad de valor que representa las dimensiones físicas de un producto.
///
/// Se utiliza para calcular costos de envío y para mostrar
/// información de empaque al cliente.
class ProductDimensions extends Equatable {
  /// Altura en centímetros.
  final double height;

  /// Ancho en centímetros.
  final double width;

  /// Profundidad en centímetros.
  final double depth;

  /// Constructor de las dimensiones del producto.
  const ProductDimensions({
    required this.height,
    required this.width,
    required this.depth,
  });

  /// Calcula el volumen total en centímetros cúbicos.
  double get volume => height * width * depth;

  /// Calcula el peso volumétrico para envío.
  ///
  /// El peso volumétrico es una medida estándar en logística
  /// que relaciona el volumen con el peso facturable.
  double get volumetricWeight => volume / 5000;

  /// Retorna las dimensiones formateadas como cadena.
  String get formatted => '${height}x${width}x${depth} cm';

  @override
  List<Object?> get props => [height, width, depth];
}

/// Extensión que añade funcionalidad adicional a la lista de productos.
///
/// Proporciona métodos de utilidad para filtrar y ordenar
/// colecciones de productos.
extension ProductListExtension on List<Product> {
  /// Filtra solo los productos disponibles para compra.
  List<Product> get available =>
      where((p) => p.isAvailable && p.stockQuantity > 0).toList();

  /// Filtra los productos destacados.
  List<Product> get featured => where((p) => p.isFeatured).toList();

  /// Filtra los productos con bajo stock.
  List<Product> get lowStock => where((p) => p.isLowStock).toList();

  /// Ordena los productos por precio ascendente.
  List<Product> sortByPriceAscending() {
    final sorted = List<Product>.from(this);
    sorted.sort((a, b) => a.price.compareTo(b.price));
    return sorted;
  }

  /// Ordena los productos por precio descendente.
  List<Product> sortByPriceDescending() {
    final sorted = List<Product>.from(this);
    sorted.sort((a, b) => b.price.compareTo(a.price));
    return sorted;
  }

  /// Filtra productos por categoría.
  List<Product> filterByCategory(String category) {
    return where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
  }

  /// Busca productos por nombre o descripción.
  List<Product> search(String query) {
    final lowerQuery = query.toLowerCase();
    return where((p) =>
        p.name.toLowerCase().contains(lowerQuery) ||
        p.description.toLowerCase().contains(lowerQuery) ||
        p.tags.any((tag) => tag.toLowerCase().contains(lowerQuery))).toList();
  }
}

// === ARCHIVO: client/lib/domain/repositories/order_repository.dart ===
package pedidos_app.domain.repositories;

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/domain/entities/order.dart';

abstract class OrderRepository {
  /// Obtiene todos los pedidos del sistema.
  /// Retorna [Either] con [Failure] en caso de error o [List<Order>] en caso de éxito.
  Future<Either<Failure, List<Order>>> getOrders();

  /// Obtiene un pedido específico por su identificador.
  /// [id] - Identificador único del pedido.
  /// Retorna [Either] con [Failure] o [Order] encontrado.
  Future<Either<Failure, Order>> getOrderById(String id);

  /// Crea un nuevo pedido en el sistema.
  /// [request] - Datos necesarios para crear el pedido.
  /// Retorna [Either] con [Failure] o el [Order] creado.
  Future<Either<Failure, Order>> createOrder(CreateOrderRequest request);
}

class CreateOrderRequest extends Equatable {
  final String clientId;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final String deliveryAddress;
  final List<OrderItemRequest> items;
  final String? notes;

  const CreateOrderRequest({
    required this.clientId,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.deliveryAddress,
    required this.items,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientPhone': clientPhone,
      'deliveryAddress': deliveryAddress,
      'items': items.map((item) => item.toJson()).toList(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  List<Object?> get props => [
        clientId,
        clientName,
        clientEmail,
        clientPhone,
        deliveryAddress,
        items,
        notes,
      ];
}

class OrderItemRequest extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;

  const OrderItemRequest({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  double get subtotal => quantity * unitPrice;

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  @override
  List<Object?> get props => [productId, productName, quantity, unitPrice];
}

// === ARCHIVO: client/lib/domain/repositories/product_repository.dart ===
package pedidos_app.domain.repositories;

import 'package:dartz/dartz.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/domain/entities/product.dart';

abstract class ProductRepository {
  /// Obtiene todos los productos disponibles en el catálogo.
  /// Retorna [Either] con [Failure] en caso de error o [List<Product>] en caso de éxito.
  Future<Either<Failure, List<Product>>> getProducts();

  /// Obtiene un producto específico por su identificador.
  /// [id] - Identificador único del producto.
  /// Retorna [Either] con [Failure] o [Product] encontrado.
  Future<Either<Failure, Product>> getProductById(String id);

  /// Busca productos por término de búsqueda.
  /// [query] - Término de búsqueda en nombre o descripción.
  /// Retorna [Either] con [Failure] o [List<Product>] que coinciden.
  Future<Either<Failure, List<Product>>> searchProducts(String query);

  /// Obtiene los productos destacados para mostrar en pantalla principal.
  /// Retorna [Either] con [Failure] o [List<Product>] destacados.
  Future<Either<Failure, List<Product>>> getFeaturedProducts();

  /// Obtiene los productos por categoría.
  /// [categoryId] - Identificador de la categoría.
  /// Retorna [Either] con [Failure] o [List<Product>] de esa categoría.
  Future<Either<Failure, List<Product>>> getProductsByCategory(String categoryId);
}

// === ARCHIVO: client/lib/data/models/order_model.dart ===
package pedidos_app.data.models;

import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String id;
  final String customerId;
  final String customerName;
  final String status;
  final List<OrderItemModel> items;
  final double totalAmount;
  final String currency;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? shippingAddress;
  final String? notes;

  const OrderModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.currency,
    required this.createdAt,
    this.updatedAt,
    this.shippingAddress,
    this.notes,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String? ?? '',
      customerId: json['customer_id'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalAmount: _parseDouble(json['total_amount']),
      currency: json['currency'] as String? ?? 'USD',
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseNullableDateTime(json['updated_at']),
      shippingAddress: json['shipping_address'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'customer_name': customerName,
      'status': status,
      'items': items.map((e) => e.toJson()).toList(),
      'total_amount': totalAmount,
      'currency': currency,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'shipping_address': shippingAddress,
      'notes': notes,
    };
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return DateTime.now();
  }

  static DateTime? _parseNullableDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  OrderModel copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? status,
    List<OrderItemModel>? items,
    double? totalAmount,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? shippingAddress,
    String? notes,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      status: status ?? this.status,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        status,
        items,
        totalAmount,
        currency,
        createdAt,
        updatedAt,
        shippingAddress,
        notes,
      ];
}

class OrderItemModel extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double subtotal;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product_id'] as String? ?? '',
      productName: json['product_name'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      unitPrice: _parseDouble(json['unit_price']),
      subtotal: _parseDouble(json['subtotal']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'unit_price': unitPrice,
      'subtotal': subtotal,
    };
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  List<Object?> get props => [
        productId,
        productName,
        quantity,
        unitPrice,
        subtotal,
      ];
}

class CreateOrderRequest extends Equatable {
  final String customerId;
  final String customerName;
  final List<CreateOrderItemRequest> items;
  final String? shippingAddress;
  final String? notes;

  const CreateOrderRequest({
    required this.customerId,
    required this.customerName,
    required this.items,
    this.shippingAddress,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'customer_name': customerName,
      'items': items.map((e) => e.toJson()).toList(),
      'shipping_address': shippingAddress,
      'notes': notes,
    };
  }

  @override
  List<Object?> get props => [
        customerId,
        customerName,
        items,
        shippingAddress,
        notes,
      ];
}

class CreateOrderItemRequest extends Equatable {
  final String productId;
  final int quantity;

  const CreateOrderItemRequest({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [productId, quantity];
}

// === ARCHIVO: client/lib/data/models/product_model.dart ===
package pedidos_app.data.models;

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final String category;
  final String? imageUrl;
  final int stockQuantity;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.category,
    this.imageUrl,
    required this.stockQuantity,
    required this.isAvailable,
    required this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: _parseDouble(json['price']),
      currency: json['currency'] as String? ?? 'USD',
      category: json['category'] as String? ?? 'general',
      imageUrl: json['image_url'] as String?,
      stockQuantity: json['stock_quantity'] as int? ?? 0,
      isAvailable: json['is_available'] as bool? ?? true,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseNullableDateTime(json['updated_at']),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'category': category,
      'image_url': imageUrl,
      'stock_quantity': stockQuantity,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return DateTime.now();
  }

  static DateTime? _parseNullableDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? currency,
    String? category,
    String? imageUrl,
    int? stockQuantity,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        currency,
        category,
        imageUrl,
        stockQuantity,
        isAvailable,
        createdAt,
        updatedAt,
        metadata,
      ];
}

// === ARCHIVO: client/lib/data/repositories/order_repository_impl.dart ===
package pedidos_app.data.repositories;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pedidos_app/core/constants/api_constants.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/data/datasources/order_remote_datasource.dart';
import 'package:pedidos_app/data/models/order_model.dart';
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  const OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Order>>> getOrders() async {
    try {
      final orderModels = await remoteDataSource.getOrders();
      final orders = orderModels.map(_mapModelToEntity).toList();
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on OfflineException {
      return const Left(OfflineFailure());
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, Order>> getOrderById(String id) async {
    try {
      final orderModel = await remoteDataSource.getOrderById(id);
      final order = _mapModelToEntity(orderModel);
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on OfflineException {
      return const Left(OfflineFailure());
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, Order>> createOrder({
    required String customerId,
    required String customerName,
    required List<CreateOrderItemRequest> items,
    String? shippingAddress,
    String? notes,
  }) async {
    try {
      final createRequest = CreateOrderRequest(
        customerId: customerId,
        customerName: customerName,
        items: items,
        shippingAddress: shippingAddress,
        notes: notes,
      );
      final orderModel = await remoteDataSource.createOrder(createRequest);
      final order = _mapModelToEntity(orderModel);
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on OfflineException {
      return const Left(OfflineFailure());
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Error inesperado: $e'));
    }
  }

  Order _mapModelToEntity(OrderModel model) {
    return Order(
      id: model.id,
      customerId: model.customerId,
      customerName: model.customerName,
      status: _mapStatus(model.status),
      items: model.items.map(_mapItemModelToEntity).toList(),
      totalAmount: model.totalAmount,
      currency: model.currency,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      shippingAddress: model.shippingAddress,
      notes: model.notes,
    );
  }

  OrderItem _mapItemModelToEntity(OrderItemModel model) {
    return OrderItem(
      productId: model.productId,
      productName: model.productName,
      quantity: model.quantity,
      unitPrice: model.unitPrice,
      subtotal: model.subtotal,
    );
  }

  OrderStatus _mapStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(message: 'Tiempo de conexión agotado');
      case DioExceptionType.connectionError:
        return const NetworkFailure(message: 'Sin conexión a internet');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] as String? ??
            'Error del servidor';
        return ServerFailure(message: message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Solicitud cancelada');
      default:
        return ServerFailure(message: e.message ?? 'Error de red desconocido');
    }
  }
}

// === ARCHIVO: client/lib/data/repositories/product_repository_impl.dart ===
package pedidos_app.data.repositories;

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/data/datasources/product_remote_datasource.dart';
import 'package:pedidos_app/domain/entities/product.dart';
import 'package:pedidos_app/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productModels = await remoteDataSource.getProducts();
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ParseException catch (e) {
      return Left(ParseFailure(message: e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on OfflineException catch (e) {
      return Left(OfflineFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Error inesperado: ${e.toString()}'));
    }
  }
}

class CreateProductRequest extends Equatable {
  final String name;
  final String description;
  final double price;
  final String category;
  final int stock;
  final String? imageUrl;

  const CreateProductRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'stock': stock,
        if (imageUrl != null) 'imageUrl': imageUrl,
      };

  @override
  List<Object?> get props => [name, description, price, category, stock, imageUrl];
}

// === ARCHIVO: client/lib/data/datasources/order_remote_datasource.dart ===
package pedidos_app.data.datasources;

import 'package:dio/dio.dart';
import 'package:pedidos_app/core/constants/api_constants.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(String id);
  Future<OrderModel> createOrder(CreateOrderRequestModel request);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.ordersEndpoint);
      final response = await dio.get(
        url,
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Error al obtener pedidos',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return [];
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    try {
      final url = ApiConstants.buildOrderByIdUrl(id);
      final response = await dio.get(
        url,
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Error al obtener el pedido',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw ServerException(message: 'Error desconocido al obtener pedido');
  }

  @override
  Future<OrderModel> createOrder(CreateOrderRequestModel request) async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.ordersEndpoint);
      final response = await dio.post(
        url,
        data: request.toJson(),
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return OrderModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Error al crear el pedido',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw ServerException(message: 'Error desconocido al crear pedido');
  }

  Never _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(
          message: 'Tiempo de conexión agotado',
          underlyingError: e.message,
        );
      case DioExceptionType.connectionError:
        throw OfflineException(
          message: 'Sin conexión a internet',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        String message = 'Error del servidor';
        String? errorCode;

        if (data is Map<String, dynamic>) {
          message = data['message'] as String? ?? message;
          errorCode = data['errorCode'] as String?;
        }

        if (statusCode == 401) {
          throw AuthenticationException(message: message);
        }

        throw ServerException(
          message: message,
          statusCode: statusCode,
          errorCode: errorCode,
        );
      case DioExceptionType.cancel:
        throw ServerException(message: 'Solicitud cancelada');
      default:
        throw ServerException(
          message: e.message ?? 'Error de red desconocido',
        );
    }
  }
}

class CreateOrderRequestModel {
  final String? customerId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String deliveryAddress;
  final List<OrderItemModel> items;
  final String? notes;

  const CreateOrderRequestModel({
    this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.items,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        if (customerId != null) 'customerId': customerId,
        'customerName': customerName,
        'customerEmail': customerEmail,
        'customerPhone': customerPhone,
        'deliveryAddress': deliveryAddress,
        'items': items.map((item) => item.toJson()).toList(),
        if (notes != null) 'notes': notes,
      };
}

class OrderItemModel {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double? discount;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.discount,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'quantity': quantity,
        'unitPrice': unitPrice,
        if (discount != null) 'discount': discount,
      };
}

// === ARCHIVO: client/lib/data/datasources/product_remote_datasource.dart ===
package pedidos_app.data.datasources;

import 'package:dio/dio.dart';
import 'package:pedidos_app/core/constants/api_constants.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<ProductModel> searchProduct(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.productsEndpoint);
      final response = await dio.get(
        url,
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Error al obtener productos',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return [];
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final url = '${ApiConstants.buildUrl(ApiConstants.productsEndpoint)}/$id';
      final response = await dio.get(
        url,
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Error al obtener el producto',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw ServerException(message: 'Error desconocido al obtener producto');
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final url = ApiConstants.buildUrl('${ApiConstants.productsEndpoint}/category/$category');
      final response = await dio.get(
        url,
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Error al obtener productos por categoría',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return [];
  }

  @override
  Future<ProductModel> searchProduct(String query) async {
    try {
      final url = ApiConstants.buildUrl('${ApiConstants.productsEndpoint}/search');
      final response = await dio.get(
        url,
        queryParameters: {'q': query},
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Error al buscar producto',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw ServerException(message: 'Error desconocido al buscar producto');
  }

  Never _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(
          message: 'Tiempo de conexión agotado',
          underlyingError: e.message,
        );
      case DioExceptionType.connectionError:
        throw OfflineException(
          message: 'Sin conexión a internet',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        String message = 'Error del servidor';
        String? errorCode;

        if (data is Map<String, dynamic>) {
          message = data['message'] as String? ?? message;
          errorCode = data['errorCode'] as String?;
        }

        if (statusCode == 401) {
          throw AuthenticationException(message: message);
        }

        throw ServerException(
          message: message,
          statusCode: statusCode,
          errorCode: errorCode,
        );
      case DioExceptionType.cancel:
        throw ServerException(message: 'Solicitud cancelada');
      default:
        throw ServerException(
          message: e.message ?? 'Error de red desconocido',
        );
    }
  }
}

// === ARCHIVO: client/lib/presentation/screens/orders_screen.dart ===
package:pedidos_app.presentation.screens;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos_app/presentation/blocs/order/order_bloc.dart';
import 'package:pedidos_app/presentation/blocs/order/order_event.dart';
import 'package:pedidos_app/presentation/blocs/order/order_state.dart';
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/presentation/screens/order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(LoadOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Pedidos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<OrderBloc>().add(LoadOrdersEvent());
            },
            tooltip: 'Actualizar pedidos',
          ),
        ],
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderInitial || state is OrderLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Cargando pedidos...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is OrderError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar pedidos',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<OrderBloc>().add(LoadOrdersEvent());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is OrdersLoaded) {
            if (state.orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No tienes pedidos aún',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Realiza tu primer pedido para verlo aquí',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<OrderBloc>().add(LoadOrdersEvent());
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return _OrderCard(
                    order: order,
                    onTap: () => _navigateToDetail(context, order),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(orderId: order.id),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const _OrderCard({
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedido #${order.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _buildStatusChip(order.status),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _formatDate(order.createdAt),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${order.items.length} ${order.items.length == 1 ? 'producto' : 'productos'}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '\$${order.total.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'completado':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'pending':
      case 'pendiente':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 'cancelled':
      case 'cancelado':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case 'processing':
      case 'procesando':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// === ARCHIVO: client/lib/presentation/screens/order_detail_screen.dart ===
package:pedidos_app.presentation.screens;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos_app/presentation/blocs/order/order_bloc.dart';
import 'package:pedidos_app/presentation/blocs/order/order_event.dart';
import 'package:pedidos_app/presentation/blocs/order/order_state.dart';
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/domain/entities/order_item.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(LoadOrderByIdEvent(widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle del Pedido',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading || state is OrderInitial) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Cargando detalles del pedido...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is OrderError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar el pedido',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<OrderBloc>()
                            .add(LoadOrderByIdEvent(widget.orderId));
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is OrderDetailLoaded) {
            return _buildOrderDetail(context, state.order);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOrderDetail(BuildContext context, Order order) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(context, order),
          const SizedBox(height: 24),
          _buildStatusSection(context, order),
          const SizedBox(height: 24),
          _buildItemsSection(context, order),
          const SizedBox(height: 24),
          _buildSummarySection(context, order),
          const SizedBox(height: 24),
          _buildActionsSection(context, order),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pedido #${order.id}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(
              Icons.calendar_today,
              'Fecha de creación',
              _formatDateTime(order.createdAt),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.access_time,
              'Última actualización',
              _formatDateTime(order.updatedAt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection(BuildContext context, Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estado del Pedido',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatusTimeline(order.status),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(String status) {
    final statuses = ['pending', 'processing', 'completed'];
    final currentIndex = statuses.indexOf(status.toLowerCase());

    return Row(
      children: List.generate(statuses.length * 2 - 1, (index) {
        if (index.isOdd) {
          final lineIndex = index ~/ 2;
          final isCompleted = lineIndex < currentIndex;
          return Expanded(
            child: Container(
              height: 2,
              color: isCompleted ? Colors.green : Colors.grey.shade300,
            ),
          );
        } else {
          final stepIndex = index ~/ 2;
          final isCompleted = stepIndex <= currentIndex;
          final isCurrent = stepIndex == currentIndex;

          return Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? Colors.green : Colors.grey.shade300,
                  border: isCurrent
                      ? Border.all(color: Colors.green, width: 2)
                      : null,
                ),
                child: Icon(
                  isCompleted ? Icons.check : Icons.circle,
                  size: 16,
                  color: isCompleted ? Colors.white : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _getStatusLabel(statuses[stepIndex]),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  color: isCurrent ? Colors.green : Colors.grey,
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pendiente';
      case 'processing':
        return 'Procesando';
      case 'completed':
        return 'Completado';
      default:
        return status;
    }
  }

  Widget _buildItemsSection(BuildContext context, Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Productos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${order.items.length} ${order.items.length == 1 ? 'item' : 'items'}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...order.items.map((item) => _buildItemTile(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTile(OrderItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cantidad: ${item.quantity}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${(item.price * item.quantity).toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context, Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Subtotal', order.subtotal),
            const SizedBox(height: 8),
            _buildSummaryRow('Impuestos', order.tax),
            const SizedBox(height: 8),
            _buildSummaryRow('Envío', order.shippingCost),
            const Divider(height: 24),
            _buildSummaryRow(
              'Total',
              order.total,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey.shade700,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.green.shade700 : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context, Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (order.status.toLowerCase() == 'pending')
          ElevatedButton.icon(
            onPressed: () {
              context.read<OrderBloc>().add(CancelOrderEvent(order.id));
            },
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Cancelar Pedido'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.support_agent_outlined),
          label: const Text('Contactar Soporte'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'completado':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'pending':
      case 'pendiente':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 'cancelled':
      case 'cancelado':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case 'processing':
      case 'procesando':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    return '${date.day}/${date.month}/${date.year} a las ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// === ARCHIVO: client/lib/presentation/screens/products_screen.dart ===
package pedidos_app.presentation.screens;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos_app/domain/entities/product.dart';
import 'package:pedidos_app/presentation/blocs/product/product_bloc.dart';
import 'package:pedidos_app/presentation/blocs/product/product_event.dart';
import 'package:pedidos_app/presentation/blocs/product/product_state.dart';
import 'package:pedidos_app/core/errors/failures.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Productos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ProductBloc>().add(LoadProductsEvent());
            },
            tooltip: 'Actualizar productos',
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando productos...'),
                ],
              ),
            );
          }

          if (state is ProductError) {
            return _buildErrorWidget(state.failure);
          }

          if (state is ProductLoaded) {
            return _buildProductsList(state.products);
          }

          return const Center(
            child: Text('Iniciando carga de productos...'),
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(Failure failure) {
    final String message;
    final IconData icon;
    final Color backgroundColor;

    if (failure is NetworkFailure) {
      message = 'Sin conexión a internet. Verifica tu conexión e intenta nuevamente.';
      icon = Icons.wifi_off;
      backgroundColor = Colors.orange.shade100;
    } else if (failure is ServerFailure) {
      message = 'Error del servidor: ${failure.message}';
      icon = Icons.cloud_off;
      backgroundColor = Colors.red.shade100;
    } else if (failure is CacheFailure) {
      message = 'Error al cargar datos locales.';
      icon = Icons.storage;
      backgroundColor = Colors.amber.shade100;
    } else if (failure is OfflineFailure) {
      message = 'Estás sin conexión. некоторые функции pueden estar limitadas.';
      icon = Icons.signal_wifi_connected_no_internet_4;
      backgroundColor = Colors.grey.shade300;
    } else {
      message = 'Ocurrió un error inesperado: ${failure.message}';
      icon = Icons.error_outline;
      backgroundColor = Colors.red.shade50;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                context.read<ProductBloc>().add(LoadProductsEvent());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsList(List<Product> products) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay productos disponibles',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pronto añadiremos nuevos productos',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductBloc>().add(LoadProductsEvent());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _ProductCard(product: product);
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priceFormatted = '\$${product.price.toStringAsFixed(2)}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showProductDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (product.description != null &&
                        product.description!.isNotEmpty)
                      Text(
                        product.description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          priceFormatted,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildAvailabilityBadge(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: product.imageUrl != null && product.imageUrl!.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderIcon();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                    ),
                  );
                },
              ),
            )
          : _buildPlaceholderIcon(),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Icon(
      Icons.shopping_bag_outlined,
      size: 32,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildAvailabilityBadge() {
    final bool isAvailable = product.isAvailable;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isAvailable ? 'Disponible' : 'Agotado',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isAvailable ? Colors.green.shade800 : Colors.red.shade800,
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  if (product.imageUrl != null && product.imageUrl!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.imageUrl!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.image_not_supported,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style:
                            Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      _buildAvailabilityBadge(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Descripción',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? 'Sin descripción disponible',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  if (product.category != null) ...[
                    Text(
                      'Categoría',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(product.category!),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                    ),
                    const SizedBox(height: 24),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: product.isAvailable
                          ? () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} añadido al carrito',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: 'Deshacer',
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        product.isAvailable
                            ? 'Añadir al carrito'
                            : 'Producto no disponible',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// === ARCHIVO: client/lib/presentation/blocs/order/order_event.dart ===
package pedidos_app.presentation.blocs.order;

import 'package:equatable/equatable.dart';
import 'package:pedidos_app/domain/entities/order.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrdersEvent extends OrderEvent {
  const LoadOrdersEvent();
}

class LoadOrderByIdEvent extends OrderEvent {
  final String orderId;

  const LoadOrderByIdEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class CreateOrderEvent extends OrderEvent {
  final Order order;

  const CreateOrderEvent(this.order);

  @override
  List<Object?> get props => [order];
}

class RefreshOrdersEvent extends OrderEvent {
  const RefreshOrdersEvent();
}

class ClearOrderErrorEvent extends OrderEvent {
  const ClearOrderErrorEvent();
}
"// === ARCHIVO: lib/presentation/blocs/order/order_state.dart ===
package pedidos_app.presentation.blocs.order;

import 'package:equatable/equatable.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/domain/entities/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrdersLoaded extends OrderState {
  final List<Order> orders;
  final DateTime loadedAt;

  const OrdersLoaded({
    required this.orders,
    required this.loadedAt,
  });

  @override
  List<Object?> get props => [orders, loadedAt];
}

class OrderDetailLoaded extends OrderState {
  final Order order;

  const OrderDetailLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderCreated extends OrderState {
  final Order order;

  const OrderCreated(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderError extends OrderState {
  final String message;
  final Failure failure;

  const OrderError({
    required this.message,
    required this.failure,
  });

  @override
  List<Object?> get props => [message, failure];
}

class OrderOperationInProgress extends OrderState {
  final String operation;

  const OrderOperationInProgress(this.operation);

  @override
  List<Object?> get props => [operation];
}
"// === ARCHIVO: lib/presentation/blocs/order/order_bloc.dart ===
package pedidos_app.presentation.blocs.order;

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/domain/repositories/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(const OrderInitial()) {
    on<LoadOrdersEvent>(_onLoadOrders);
    on<LoadOrderByIdEvent>(_onLoadOrderById);
    on<CreateOrderEvent>(_onCreateOrder);
    on<RefreshOrdersEvent>(_onRefreshOrders);
    on<ClearOrderErrorEvent>(_onClearError);
  }

  Future<void> _onLoadOrders(
    LoadOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderLoading());
    try {
      final result = await orderRepository.getOrders();
      result.fold(
        (failure) => emit(OrderError(
          message: failure.message,
          failure: failure,
        )),
        (orders) => emit(OrdersLoaded(
          orders: orders,
          loadedAt: DateTime.now(),
        )),
      );
    } on ServerException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on NetworkException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on OfflineException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } catch (e) {
      emit(OrderError(
        message: 'Error inesperado al cargar pedidos: ${e.toString()}',
        failure: const ServerFailure(message: 'Error inesperado'),
      ));
    }
  }

  Future<void> _onLoadOrderById(
    LoadOrderByIdEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderLoading());
    try {
      final result = await orderRepository.getOrderById(event.orderId);
      result.fold(
        (failure) => emit(OrderError(
          message: failure.message,
          failure: failure,
        )),
        (order) => emit(OrderDetailLoaded(order)),
      );
    } on ServerException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on NetworkException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on OfflineException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } catch (e) {
      emit(OrderError(
        message: 'Error inesperado al cargar el pedido: ${e.toString()}',
        failure: const ServerFailure(message: 'Error inesperado'),
      ));
    }
  }

  Future<void> _onCreateOrder(
    CreateOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderOperationInProgress('Creando pedido...'));
    try {
      final result = await orderRepository.createOrder(event.order);
      result.fold(
        (failure) => emit(OrderError(
          message: failure.message,
          failure: failure,
        )),
        (order) => emit(OrderCreated(order)),
      );
    } on ServerException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on NetworkException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on OfflineException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } catch (e) {
      emit(OrderError(
        message: 'Error inesperado al crear el pedido: ${e.toString()}',
        failure: const ServerFailure(message: 'Error inesperado'),
      ));
    }
  }

  Future<void> _onRefreshOrders(
    RefreshOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final result = await orderRepository.getOrders();
      result.fold(
        (failure) => emit(OrderError(
          message: failure.message,
          failure: failure,
        )),
        (orders) => emit(OrdersLoaded(
          orders: orders,
          loadedAt: DateTime.now(),
        )),
      );
    } on ServerException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on NetworkException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } catch (e) {
      emit(OrderError(
        message: 'Error al actualizar pedidos: ${e.toString()}',
        failure: const ServerFailure(message: 'Error inesperado'),
      ));
    }
  }

  void _onClearError(
    ClearOrderErrorEvent event,
    Emitter<OrderState> emit,
  ) {
    emit(const OrderInitial());
  }
}

// === ARCHIVO: client/lib/presentation/blocs/product/product_event.dart ===
package pedidos_app.presentation.blocs.product;

import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {
  const LoadProducts();

  @override
  List<Object?> get props => [];
}

class RefreshProducts extends ProductEvent {
  final bool forceRefresh;

  const RefreshProducts({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterProductsByCategory extends ProductEvent {
  final String? categoryId;

  const FilterProductsByCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class SelectProduct extends ProductEvent {
  final String productId;

  const SelectProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ClearProductSelection extends ProductEvent {
  const ClearProductSelection();
}

class LoadProductDetails extends ProductEvent {
  final String productId;

  const LoadProductDetails(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ClearProductError extends ProductEvent {
  const ClearProductError();
}

// === ARCHIVO: client/lib/presentation/blocs/product/product_state.dart ===
package pedidos_app.presentation.blocs.product;

import 'package:equatable/equatable.dart';
import 'package:pedidos_app/domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  final List<Product> currentProducts;

  const ProductLoading({this.currentProducts = const []});

  @override
  List<Object?> get props => [currentProducts];
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final Product? selectedProduct;
  final String? activeCategoryFilter;
  final String? searchQuery;
  final bool isRefreshing;
  final DateTime lastUpdated;

  const ProductLoaded({
    required this.products,
    this.selectedProduct,
    this.activeCategoryFilter,
    this.searchQuery,
    this.isRefreshing = false,
    required this.lastUpdated,
  });

  ProductLoaded copyWith({
    List<Product>? products,
    Product? selectedProduct,
    bool clearSelection = false,
    String? activeCategoryFilter,
    bool clearCategoryFilter = false,
    String? searchQuery,
    bool clearSearchQuery = false,
    bool? isRefreshing,
    DateTime? lastUpdated,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      selectedProduct: clearSelection ? null : (selectedProduct ?? this.selectedProduct),
      activeCategoryFilter: clearCategoryFilter ? null : (activeCategoryFilter ?? this.activeCategoryFilter),
      searchQuery: clearSearchQuery ? null : (searchQuery ?? this.searchQuery),
      isRefreshing: isRefreshing ?? this.isRefreshing,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  List<Product> get filteredProducts {
    var result = products;

    if (activeCategoryFilter != null && activeCategoryFilter!.isNotEmpty) {
      result = result.where((p) => p.categoryId == activeCategoryFilter).toList();
    }

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      result = result.where((p) => 
        p.name.toLowerCase().contains(query) ||
        p.description.toLowerCase().contains(query)
      ).toList();
    }

    return result;
  }

  @override
  List<Object?> get props => [
    products,
    selectedProduct,
    activeCategoryFilter,
    searchQuery,
    isRefreshing,
    lastUpdated,
  ];
}

class ProductError extends ProductState {
  final String message;
  final List<Product> previousProducts;
  final bool canRetry;

  const ProductError({
    required this.message,
    this.previousProducts = const [],
    this.canRetry = true,
  });

  ProductError copyWith({
    String? message,
    List<Product>? previousProducts,
    bool? canRetry,
  }) {
    return ProductError(
      message: message ?? this.message,
      previousProducts: previousProducts ?? this.previousProducts,
      canRetry: canRetry ?? this.canRetry,
    );
  }

  @override
  List<Object?> get props => [message, previousProducts, canRetry];
}

class ProductOperationSuccess extends ProductState {
  final String message;
  final Product? product;
  final List<Product> updatedProducts;

  const ProductOperationSuccess({
    required this.message,
    this.product,
    required this.updatedProducts,
  });

  @override
  List<Object?> get props => [message, product, updatedProducts];
}

// === ARCHIVO: client/lib/presentation/blocs/product/product_bloc.dart ===
package pedidos_app.presentation.blocs.product;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pedidos_app/domain/entities/product.dart';
import 'package:pedidos_app/domain/repositories/product_repository.dart';
import 'package:pedidos_app/core/errors/failures.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(const ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProducts>(_onRefreshProducts);
    on<SearchProducts>(_onSearchProducts);
    on<FilterProductsByCategory>(_onFilterProductsByCategory);
    on<SelectProduct>(_onSelectProduct);
    on<ClearProductSelection>(_onClearProductSelection);
    on<LoadProductDetails>(_onLoadProductDetails);
    on<ClearProductError>(_onClearProductError);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    List<Product> currentProducts = [];
    
    if (currentState is ProductLoaded) {
      currentProducts = currentState.products;
    }

    emit(ProductLoading(currentProducts: currentProducts));

    final result = await productRepository.getProducts();

    result.fold(
      (failure) => emit(ProductError(
        message: _mapFailureToMessage(failure),
        previousProducts: currentProducts,
        canRetry: true,
      )),
      (products) => emit(ProductLoaded(
        products: products,
        lastUpdated: DateTime.now(),
      )),
    );
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      emit(currentState.copyWith(isRefreshing: true));
    }

    final Either<Failure, List<Product>> result;
    
    if (event.forceRefresh) {
      result = await productRepository.getProducts();
    } else {
      result = await productRepository.getProducts();
    }

    result.fold(
      (failure) {
        if (currentState is ProductLoaded) {
          emit(ProductError(
            message: _mapFailureToMessage(failure),
            previousProducts: currentState.products,
            canRetry: true,
          ));
        } else {
          emit(ProductError(
            message: _mapFailureToMessage(failure),
            previousProducts: const [],
            canRetry: true,
          ));
        }
      },
      (products) {
        final newState = ProductLoaded(
          products: products,
          activeCategoryFilter: currentState is ProductLoaded ? currentState.activeCategoryFilter : null,
          searchQuery: currentState is ProductLoaded ? currentState.searchQuery : null,
          lastUpdated: DateTime.now(),
        );
        emit(newState);
      },
    );
  }

  void _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      if (event.query.isEmpty) {
        emit(currentState.copyWith(clearSearchQuery: true));
      } else {
        emit(currentState.copyWith(searchQuery: event.query));
      }
    }
  }

  void _onFilterProductsByCategory(
    FilterProductsByCategory event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      if (event.categoryId == null || event.categoryId!.isEmpty) {
        emit(currentState.copyWith(clearCategoryFilter: true));
      } else {
        emit(currentState.copyWith(activeCategoryFilter: event.categoryId));
      }
    }
  }

  Future<void> _onSelectProduct(
    SelectProduct event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      final product = currentState.products.firstWhere(
        (p) => p.id == event.productId,
        orElse: () => throw Exception('Producto no encontrado'),
      );
      
      emit(currentState.copyWith(selectedProduct: product));
    }
  }

  void _onClearProductSelection(
    ClearProductSelection event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      emit(currentState.copyWith(clearSelection: true));
    }
  }

  Future<void> _onLoadProductDetails(
    LoadProductDetails event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      final product = currentState.products.firstWhere(
        (p) => p.id == event.productId,
        orElse: () => throw Exception('Producto no encontrado'),
      );
      
      emit(currentState.copyWith(selectedProduct: product));
    } else {
      final result = await productRepository.getProductById(event.productId);
      
      result.fold(
        (failure) => emit(ProductError(
          message: _mapFailureToMessage(failure),
          canRetry: true,
        )),
        (product) {
          if (currentState is ProductLoaded) {
            emit(currentState.copyWith(selectedProduct: product));
          } else {
            emit(ProductLoaded(
              products: [product],
              selectedProduct: product,
              lastUpdated: DateTime.now(),
            ));
          }
        },
      );
    }
  }

  void _onClearProductError(
    ClearProductError event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductError) {
      if (currentState.previousProducts.isNotEmpty) {
        emit(ProductLoaded(
          products: currentState.previousProducts,
          lastUpdated: DateTime.now(),
        ));
      } else {
        emit(const ProductInitial());
      }
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return 'Error de conexión. Verifica tu conexión a internet.';
    } else if (failure is CacheFailure) {
      return 'Error al acceder a datos locales.';
    } else if (failure is OfflineFailure) {
      return 'Sin conexión a internet. Por favor, verifica tu red.';
    } else {
      return 'Ha ocurrido un error inesperado.';
    }
  }
}

// === ARCHIVO: client/android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.pedidos_app">
    
    <!-- Permisos de red necesarios para consumo de APIs REST -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    
    <!-- Permiso para conexiones seguras (TLS 1.2+) -->
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
    
    <application
        android:label="Pedidos App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:enableOnBackInvokedCallback="true">
        
        <!-- Actividad principal de Flutter -->
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <!-- Configuración del splash screen -->
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme"/>
            
            <!-- Intent filter para launcher -->
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        
        <!-- Metadatos de Flutter -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2"/>
        
        <!-- Configuración de red para APIs externas -->
        <meta-data
            android:name="com.example.pedidos_app.api.baseurl"
            android:value="http://api.pedidos.example.com"/>
        
        <!-- Componente de aplicación para inicialización -->
        <provider
            android:name="androidx.startup.InitializationProvider"
            android:authorities="${applicationId}.androidx-startup"
            android:exported="false"
            tools:node="merge">
            <meta-data
                android:name="androidx.flutter.embedding.android.InitializationFragment"
                android:value="androidx.fragment.app.Fragment"/>
        </provider>
        
    </application>
    
    <!-- Declaraciones de queries para APIs -->
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
    
</manifest>
```
