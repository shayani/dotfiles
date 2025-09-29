#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Installing Walker"
  paru -S --noconfirm --needed \
    walker-bin \
    elephant \
    elephant-calc \
    elephant-clipboard \
    elephant-desktopapplications
fi
