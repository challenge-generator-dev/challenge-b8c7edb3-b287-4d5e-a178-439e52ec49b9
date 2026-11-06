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