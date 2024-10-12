#!/bin/bash
# Script para encontrar e executar todos os playbooks no diretório e subdiretórios em uma única linha

# Encontrar todos os arquivos .yml
playbooks=$(find . -name "*.yml" | sort | tr '\n' ' ')

# Verificar se encontrou algum playbook
if [ -z "$playbooks" ]; then
  echo "Nenhum playbook encontrado."
  exit 1
fi

# Executar todos os playbooks em uma única linha
echo "Executando todos os playbooks: $playbooks"
ansible-playbook -i hosts, $playbooks --ask-become-pass
