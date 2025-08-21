#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Installing Hyprland dependencies on Arch Linux..."
  paru -S --needed --noconfirm \
    hyprland \
    wofi \
    hyprpaper \
    hypridle \
    waybar \
    hyprshot \
    hyprlock \
    mako \
    xdg-desktop-portal-hyprland \
    hyprpolkitagent \
    wlogout \
    matugen-bin

fi
