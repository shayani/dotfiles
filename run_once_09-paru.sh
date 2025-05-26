#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Using Arch"
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/paru.git ~/paru
  cd ~/paru
  makepkg -si
fi
