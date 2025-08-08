#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Using Arch"
  paru -Syu --noconfirm --needed \
	  visual-studio-code-bin \
	  cursor-bin \
	  cursor-cli \
	  google-chrome
fi
