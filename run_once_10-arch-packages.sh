#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Using Arch"
  paru -Syu --noconfirm --needed \
    blueman \
    bluetui \
    btop \
    fd \
    ffmpegthumbnailer \
    fish \
    fontconfig \
    git \
    gnome-keyring \
    impala \
    lazydocker-bin \
    lazygit \
    libgnome-keyring \
    mtr \
    ncdu \
    neovim \
    satty \
    slurp \
    swayosd \
    tldr \
    tmux \
    ttf-cascadia-mono-nerd \
    ttf-jetbrains-mono-nerd \
    unzip \
    walker-bin \
    wget \
    wiremix \
    wl-screenrec \
    zsh \
    zsh \
    zoxide
fi
