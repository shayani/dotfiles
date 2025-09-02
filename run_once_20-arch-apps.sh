#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Using Arch"
  paru -S --noconfirm --needed \
    visual-studio-code-bin \
    cursor-bin \
    cursor-cli \
    todoist-bin \
    postman-bin \
    google-chrome

  # Docker
  echo "Instalando Docker"
  paru -S --noconfirm --needed docker docker-compose docker-buildx
  sudo usermod -aG docker $USER
  sudo systemctl enable docker.socket
fi
