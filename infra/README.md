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