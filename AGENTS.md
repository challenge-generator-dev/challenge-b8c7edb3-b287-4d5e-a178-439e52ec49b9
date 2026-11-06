# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Despliegue de API de app de pedidos con Terraform**.

| | |
|---|---|
| Tema | Infraestructura como codigo para el backend de una app movil |
| Nivel | senior-l2 |
| Chapter | Móvil |
| Especialidad | Flutter |
| Stack | Dart / Flutter |
| Patron arquitectonico | clean architecture con MVVM |
| Tiempo estimado | 8 horas |

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

## Receta del stack

Esqueleto obligatorio:

- `pubspec.yaml en la raiz`
- `lib/main.dart con runApp`
- `lib/domain con entidades y repositorios abstractos`
- `lib/data con las implementaciones y el cliente Dio`
- `lib/presentation con screens y blocs/notifiers`

Dependencias:

- flutter_bloc 8.1.6
- dio 5.7.0
- equatable 2.0.7
- get_it 8.0.3
- dartz 0.10.1
- flutter_test sdk
- bloc_test 9.1.7
- mocktail 1.0.4

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Segui el orden de arranque del mapa de componentes (infraestructura local primero) y corre `(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)` desde la raiz: mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configuración inicial de Terraform**: Archivo `main.tf` con la configuración inicial de Terraform.
- **Fase 2 — Aprovisionamiento de recursos**: Recursos aprovisionados y verificados para el backend de la aplicación.
- **Fase 3 — Despliegue de la API**: API de la aplicación de pedidos desplegada y documentada.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/vpc/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/vpc/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/vpc/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/ecs/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/ecs/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/ecs/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/rds/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/rds/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/rds/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/elasticache/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/elasticache/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/elasticache/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/s3/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/s3/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/s3/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/iam/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/iam/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/iam/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/alb/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/alb/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/alb/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/efs/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/efs/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/efs/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Lo que falta y tenes que completar

### 1. Archivos que la arquitectura declara (2 de 58)

La propuesta arquitectonica del reto los lista y no llegaron al repo. Crealos con implementacion real, respetando la capa en la que viven:

- [ ] `client/lib/presentation/blocs/order/order_bloc.dart`
- [ ] `client/lib/presentation/blocs/order/order_state.dart`

### Presentes (59)

- `infra/providers.tf`
- `infra/variables.tf`
- `infra/modules/vpc/variables.tf`
- `infra/modules/ecs/variables.tf`
- `infra/modules/rds/variables.tf`
- `infra/modules/elasticache/variables.tf`
- `infra/modules/s3/variables.tf`
- `infra/modules/iam/variables.tf`
- `infra/modules/alb/variables.tf`
- `infra/modules/efs/variables.tf`
- `infra/modules/vpc/main.tf`
- `infra/modules/vpc/outputs.tf`
- `infra/modules/ecs/main.tf`
- `infra/modules/ecs/outputs.tf`
- `infra/modules/rds/main.tf`
- `infra/modules/rds/outputs.tf`
- `infra/modules/elasticache/main.tf`
- `infra/modules/elasticache/outputs.tf`
- `infra/modules/s3/main.tf`
- `infra/modules/s3/outputs.tf`
- `infra/modules/iam/main.tf`
- `infra/modules/iam/outputs.tf`
- `infra/modules/alb/main.tf`
- `infra/modules/alb/outputs.tf`
- `infra/modules/efs/main.tf`
- `infra/modules/efs/outputs.tf`
- `infra/versions.tf`
- `infra/main.tf`
- `infra/README.md`
- `infra/outputs.tf`
- `infra/terraform.tfvars`
- `infra/environments/dev/terraform.tfvars`
- `infra/scripts/deploy.sh`
- `infra/scripts/destroy.sh`
- `client/pubspec.yaml`
- `client/lib/main.dart`
- `client/lib/core/constants/api_constants.dart`
- `client/lib/core/errors/exceptions.dart`
- `client/lib/core/errors/failures.dart`
- `client/lib/core/network/api_client.dart`
- `client/lib/domain/entities/order.dart`
- `client/lib/domain/entities/order_item.dart`
- `client/lib/domain/entities/product.dart`
- `client/lib/domain/repositories/order_repository.dart`
- `client/lib/domain/repositories/product_repository.dart`
- `client/lib/data/models/order_model.dart`
- `client/lib/data/models/product_model.dart`
- `client/lib/data/repositories/order_repository_impl.dart`
- `client/lib/data/repositories/product_repository_impl.dart`
- `client/lib/data/datasources/order_remote_datasource.dart`
- `client/lib/data/datasources/product_remote_datasource.dart`
- `client/lib/presentation/screens/orders_screen.dart`
- `client/lib/presentation/screens/order_detail_screen.dart`
- `client/lib/presentation/screens/products_screen.dart`
- `client/lib/presentation/blocs/order/order_event.dart`
- `client/lib/presentation/blocs/product/product_event.dart`
- `client/lib/presentation/blocs/product/product_state.dart`
- `client/lib/presentation/blocs/product/product_bloc.dart`
- `client/android/app/src/main/AndroidManifest.xml`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `infra`
- `infra/modules/vpc`
- `infra/modules/ecs`
- `infra/modules/rds`
- `infra/modules/elasticache`
- `infra/modules/s3`
- `infra/modules/iam`
- `infra/modules/alb`
- `infra/modules/efs`
- `client`
- `client/lib/domain/entities`
- `client/lib/domain/repositories`
- `client/lib/data/models`
- `client/lib/data/repositories`
- `client/lib/data/datasources`
- `client/lib/presentation/screens`
- `client/lib/presentation/blocs`
- `client/lib/core/constants`
- `client/lib/core/errors`
- `client/lib/core/network`

## Verificacion

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- Cada componente vive en su carpeta: instala y compila dentro de ella, y no muevas archivos entre componentes.
- Respeta los contratos entre componentes (endpoints, topics) tal como estan declarados en el mapa de componentes.
- El patron es **clean architecture con MVVM**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2
- Brecha que el reto ataca: Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261106172943501), Aprovisiona con Terraform los recursos que consume la aplicacion movil
- Mision: Desplegar la API de la app de pedidos

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
