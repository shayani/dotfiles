#!/bin/bash

# Script para verificar pacotes disponíveis para atualização usando paru
# Autor: Sistema
# Data: $(date '+%Y-%m-%d')

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para exibir header
show_header() {
  echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${BLUE}║                 VERIFICADOR DE ATUALIZAÇÕES                  ║${NC}"
  echo -e "${BLUE}║                        usando paru                           ║${NC}"
  echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
  echo
}

# Função para verificar se o paru está instalado
check_paru() {
  if ! command -v paru &>/dev/null; then
    echo -e "${RED}Erro: paru não está instalado no sistema.${NC}"
    echo -e "${YELLOW}Instale o paru primeiro para usar este script.${NC}"
    exit 1
  fi
}

# Função para verificar atualizações
check_updates() {
  echo -e "${YELLOW}Verificando pacotes disponíveis para atualização...${NC}"
  echo

  paru -Sy >/dev/null
  # Executa paru -Qu e captura a saída
  local updates=$(paru -Qu 2>/dev/null)
  local exit_code=$?

  if [ $exit_code -eq 0 ]; then
    if [ -n "$updates" ]; then
      local count=$(echo "$updates" | wc -l)
      echo -e "${GREEN}Encontrados $count pacote(s) disponível(is) para atualização:${NC}"
      echo

      # Cabeçalho da tabela
      printf "${BLUE}%-25s %-20s %-20s${NC}\n" "PACOTE" "VERSÃO ATUAL" "NOVA VERSÃO"
      echo -e "${BLUE}════════════════════════════════════════════════════════════════════${NC}"

      while IFS= read -r line; do
        # Extrair nome do pacote e versões usando regex mais específica
        if [[ $line =~ ^([^[:space:]]+)[[:space:]]+([^[:space:]]+)[[:space:]]*-\>[[:space:]]*([^[:space:]]+)$ ]]; then
          local package_name="${BASH_REMATCH[1]}"
          local current_version="${BASH_REMATCH[2]}"
          local new_version="${BASH_REMATCH[3]}"

          # Formatar em 3 colunas com cores
          printf "${YELLOW}%-25s${NC} ${RED}%-20s${NC} ${GREEN}%-20s${NC}\n" \
            "$package_name" "$current_version" "$new_version"
        else
          # Fallback: tentar extrair versões de formato alternativo
          if [[ $line =~ ^([^[:space:]]+)[[:space:]]+(.+)$ ]]; then
            local package_name="${BASH_REMATCH[1]}"
            local version_info="${BASH_REMATCH[2]}"

            # Tentar separar versões por " -> "
            if [[ $version_info =~ ^(.+)[[:space:]]*-\>[[:space:]]*(.+)$ ]]; then
              local current_version="${BASH_REMATCH[1]}"
              local new_version="${BASH_REMATCH[2]}"
              printf "${YELLOW}%-25s${NC} ${RED}%-20s${NC} ${GREEN}%-20s${NC}\n" \
                "$package_name" "$current_version" "$new_version"
            else
              # Se não conseguir separar, exibir como antes
              printf "${YELLOW}%-25s${NC} ${GREEN}%-41s${NC}\n" "$package_name" "$version_info"
            fi
          else
            # Última opção: exibir linha completa
            echo -e "${YELLOW}$line${NC}"
          fi
        fi
      done <<<"$updates"

      echo -e "${BLUE}════════════════════════════════════════════════════════════════════${NC}"
      echo
      echo -e "${YELLOW}Para atualizar todos os pacotes, execute: ${GREEN}paru -Syu${NC}"
      echo -e "${YELLOW}Para atualizar um pacote específico, execute: ${GREEN}paru -S [nome_do_pacote]${NC}"
    else
      echo -e "${GREEN}✓ Sistema atualizado! Nenhum pacote disponível para atualização.${NC}"
    fi
  else
    echo -e "${RED}Erro ao verificar atualizações. Verifique sua conexão com a internet.${NC}"
    exit 1
  fi
}

# Função para exibir informações do sistema
show_system_info() {
  echo
  echo -e "${BLUE}Informações do Sistema:${NC}"
  echo -e "${YELLOW}Data/Hora:${NC} $(date)"
  echo -e "${YELLOW}Última atualização do sistema:${NC} $(stat -c %y /var/log/pacman.log 2>/dev/null || echo 'Não disponível')"
  echo
}

# Função principal
main() {
  show_header
  check_paru
  show_system_info
  check_updates

  echo
  echo -e "${GREEN}Script executado com sucesso!${NC}"
}

# Verificar se o script está sendo executado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
