#!/bin/bash

# Script para configurar login automático do usuário shayani
# Este script configura o sistema para iniciar sessão automaticamente

echo "Configurando login automático para o usuário shayani..."

# Verificar se estamos executando como root
if [ "$EUID" -ne 0 ]; then
    echo "Este script deve ser executado como root (use sudo)"
    exit 1
fi

# Verificar se o usuário shayani existe
if ! id "shayani" &>/dev/null; then
    echo "Erro: Usuário 'shayani' não encontrado!"
    exit 1
fi

echo "Usuário shayani encontrado. Configurando..."

# Configurar login automático no getty (tty1)
echo "Configurando getty para tty1..."
cat > /etc/systemd/system/getty@tty1.service.d/override.conf << EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin shayani --noclear %I \$TERM
Type=idle
EOF

# Criar diretório se não existir
mkdir -p /etc/systemd/system/getty@tty1.service.d/

# Configurar login automático no display manager (se estiver usando um)
echo "Configurando display manager..."

# Verificar qual display manager está sendo usado
if systemctl is-active --quiet lightdm; then
    echo "LightDM detectado. Configurando..."
    # Configurar LightDM
    cat > /etc/lightdm/lightdm.conf.d/50-autologin.conf << EOF
[Seat:*]
autologin-user=shayani
autologin-user-timeout=0
EOF
    systemctl enable lightdm
elif systemctl is-active --quiet gdm; then
    echo "GDM detectado. Configurando..."
    # Configurar GDM
    cat > /etc/gdm/custom.conf << EOF
[daemon]
AutomaticLogin=shayani
AutomaticLoginEnable=true
EOF
    systemctl enable gdm
elif systemctl is-active --quiet sddm; then
    echo "SDDM detectado. Configurando..."
    # Configurar SDDM
    cat > /etc/sddm.conf.d/autologin.conf << EOF
[Autologin]
User=shayani
Session=hyprland
EOF
    systemctl enable sddm
else
    echo "Nenhum display manager ativo detectado."
    echo "Configurando apenas getty para login automático no console."
fi

# Configurar login automático no Hyprland (se estiver instalado)
if command -v hyprland &> /dev/null; then
    echo "Hyprland detectado. Configurando..."
    
    # Criar arquivo de configuração para login automático
    mkdir -p /etc/systemd/user/
    cat > /etc/systemd/user/hyprland-session.target << EOF
[Unit]
Description=Hyprland Session
Wants=graphical-session.target
Wants=graphical-session-pre.target
After=graphical-session-pre.target

[Install]
WantedBy=default.target
EOF

    # Configurar para iniciar automaticamente
    systemctl --user enable hyprland-session.target
fi

# Recarregar configurações do systemd
echo "Recarregando configurações do systemd..."
systemctl daemon-reload

# Habilitar getty para tty1
echo "Habilitando getty para tty1..."
systemctl enable getty@tty1.service

echo ""
echo "✅ Configuração de login automático concluída!"
echo ""
echo "📋 Resumo das configurações:"
echo "   • Login automático configurado para usuário: shayani"
echo "   • Getty configurado para tty1"
echo "   • Display manager configurado (se detectado)"
echo "   • Hyprland configurado (se instalado)"
echo ""
echo "🔄 Para aplicar as mudanças, reinicie o sistema:"
echo "   sudo reboot"
echo ""
echo "⚠️  IMPORTANTE: Esta configuração remove a segurança de login por senha!"
echo "   Use apenas em ambientes controlados e seguros."
