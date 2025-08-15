#!/bin/bash

# Check if the OS is Arch Linux
if [[ ! -f /etc/arch-release ]]; then
  # Update package list and install packages for Debian-based systems
  sudo apt update
  sudo apt install -y \
    age \
    bat \
    btop \
    build-essential \
    curl \
    fontconfig \
    gcc \
    git \
    neofetch \
    procps \
    ripgrep \
    tldr \
    tmux \
    unzip \
    wget \
    wavemon \
    zoxide \
    zsh
fi
