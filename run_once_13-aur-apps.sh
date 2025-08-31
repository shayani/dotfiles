#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Instalando apps"
  paru -S --needed --noconfirm \
    brave-bin \
    todoist-bin
fi
