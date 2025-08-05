#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Using Arch"
  sudo pacman -S --needed --noconfirm git base-devel

  if ! command -v paru &> /dev/null; then
    git clone https://aur.archlinux.org/paru.git ~/paru
    cd ~/paru
    makepkg -si
  fi
fi
