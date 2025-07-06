#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Installing Hyprland dependencies on Arch Linux..."
  paru -Syu --needed \
	  hyprland \
	  wofi \
	  hyprpaper \
	  hypridle \
	  waybar \
	  hyprshot \
	  swaync \
	  xdg-desktop-portal-hyprland \
	  hyprpolkitagent \
	  matugen-bin

fi
