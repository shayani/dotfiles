#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Using Arch"
  paru -Syu --needed \
	  git zsh fontconfig btop tmux tldr unzip wget zsh fish neovim \
    github-cli \
    ncdu \
    mtr \
    zoxide
else
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
    zoxide \
    zsh
fi
