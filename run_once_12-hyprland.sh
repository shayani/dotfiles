#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Installing Hyprland dependencies on Arch Linux..."
  paru -Syu hyprland wofi hyprpaper hypridle waybar
fi
