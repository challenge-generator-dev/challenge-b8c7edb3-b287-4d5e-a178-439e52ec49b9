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