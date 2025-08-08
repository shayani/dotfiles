#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Installing Hyprland dependencies on Arch Linux..."
  paru -Syu --needed --noconfirm \
	  hyprland \
	  wofi \
	  hyprpaper \
	  hypridle \
	  waybar \
	  hyprshot \
	  hyprlock \
	  swaync \
	  xdg-desktop-portal-hyprland \
	  hyprpolkitagent \
	  matugen-bin

fi
