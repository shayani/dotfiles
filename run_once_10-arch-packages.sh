#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Using Arch"
  paru -Syu --noconfirm --needed \
	  btop \
	  fd \
	  fish \
	  fontconfig \
	  git \
	  neovim \
	  tldr \
	  tmux \
	  unzip \
	  wget \
	  zsh \
	  zsh \
    ffmpegthumbnailer \
    mtr \
    ncdu \
    zoxide
fi
