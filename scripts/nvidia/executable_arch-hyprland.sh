#!/bin/bash

# Script para configurar NVIDIA no Arch Linux com Hyprland

echo "Instalando pacotes NVIDIA..."
# Descomente as linhas abaixo se quiser instalar os pacotes automaticamente
# paru -S --noconfirm --needed \
# 	nvidia-utils \
# 	lib32-nvidia-utils \
# 	egl-wayland

echo "Configurando módulo NVIDIA..."
echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf

echo "Configurando mkinitcpio.conf..."
# Módulos NVIDIA que devem ser adicionados no início
NVIDIA_MODULES="i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm"

# Verificar se o arquivo existe
if [ ! -f /etc/mkinitcpio.conf ]; then
    echo "Erro: /etc/mkinitcpio.conf não encontrado!"
    exit 1
fi

# Fazer backup do arquivo original
sudo cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.backup
echo "Backup criado: /etc/mkinitcpio.conf.backup"

# Ler a linha MODULES atual
MODULES_LINE=$(grep "^MODULES=" /etc/mkinitcpio.conf)
echo "Linha MODULES atual: $MODULES_LINE"

# Extrair os módulos existentes (removendo MODULES= e parênteses)
EXISTING_MODULES=$(echo "$MODULES_LINE" | sed 's/MODULES=//' | sed 's/[()]//g')

# Verificar se os módulos NVIDIA já estão presentes
if echo "$EXISTING_MODULES" | grep -q "nvidia"; then
    echo "Módulos NVIDIA já estão configurados em mkinitcpio.conf"
else
    # Criar nova linha MODULES com NVIDIA no início
    NEW_MODULES_LINE="MODULES=($NVIDIA_MODULES $EXISTING_MODULES)"
    
    # Substituir a linha no arquivo
    sudo sed -i "s|^MODULES=.*|$NEW_MODULES_LINE|" /etc/mkinitcpio.conf
    
    echo "Linha MODULES atualizada para: $NEW_MODULES_LINE"
fi

echo "Verificando configuração final..."
grep "^MODULES=" /etc/mkinitcpio.conf

echo "Regenerando initramfs..."
sudo mkinitcpio -P

echo "Script concluído com sucesso!"
echo "Reinicie o sistema para aplicar as mudanças."

