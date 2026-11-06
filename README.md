# Despliegue de API de app de pedidos con Terraform

La aplicación móvil de pedidos requiere una infraestructura robusta para su backend. Utilizarás Terraform para aprovisionar los recursos necesarios. El dominio es una aplicación de pedidos para dispositivos móviles, donde los usuarios pueden realizar y gestionar sus pedidos. Los recursos incluyen servidores, bases de datos y servicios de mensajería. Debes asegurarte de que la infraestructura sea escalable y resiliente.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el backend de una app movil |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para el proyecto.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Configura el entorno de Terraform para el proyecto de la aplicación de pedidos.
- Identifica los recursos necesarios para el backend de la aplicación.
- Crea un archivo `main.tf` con la configuración inicial.

**Entregable:** Archivo `main.tf` con la configuración inicial de Terraform.

<details>
<summary>Pistas de conocimiento</summary>

- Terraform se utiliza para definir y desplegar infraestructura de forma programática.
- Los recursos de Terraform deben ser definidos de acuerdo a las necesidades del backend de la aplicación.

</details>

### Fase 2: Aprovisionamiento de recursos

**Objetivo:** Aprovisionar los recursos necesarios para el backend utilizando Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Aprovisiona los recursos necesarios para el backend de la aplicación de pedidos utilizando Terraform.
- Define los recursos en el archivo `main.tf`.
- Verifica que los recursos se hayan aprovisionado correctamente.

**Entregable:** Recursos aprovisionados y verificados para el backend de la aplicación.

<details>
<summary>Pistas de conocimiento</summary>

- Los recursos deben incluir servidores, bases de datos y servicios de mensajería.
- Utiliza Terraform para definir y desplegar los recursos.

</details>

### Fase 3: Despliegue de la API

**Objetivo:** Desplegar la API de la aplicación de pedidos utilizando la infraestructura aprovisionada.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Despliega la API de la aplicación de pedidos utilizando la infraestructura aprovisionada con Terraform.
- Verifica que la API esté funcionando correctamente.
- Documenta el proceso de despliegue.

**Entregable:** API de la aplicación de pedidos desplegada y documentada.

<details>
<summary>Pistas de conocimiento</summary>

- La API debe ser desplegada en los recursos aprovisionados.
- Verifica el funcionamiento de la API utilizando pruebas de integración.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se utiliza para aprovisionar infraestructura?
- **paraQueSirve**: ¿Para qué sirve aprovisionar infraestructura con Terraform en el contexto de una aplicación de pedidos?
- **comoSeUsa**: ¿Cómo se usa Terraform para definir y desplegar recursos en el backend de una aplicación?
- **erroresComunes**: ¿Cuáles son los errores comunes al aprovisionar infraestructura con Terraform y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el despliegue de la API utilizando la infraestructura aprovisionada con Terraform?

## Criterios de Evaluacion

- Configuración inicial de Terraform.
- Aprovisionamiento de recursos necesarios para el backend.
- Despliegue de la API utilizando la infraestructura aprovisionada.
- Verificación del funcionamiento correcto de la API.
- Documentación del proceso de despliegue.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
