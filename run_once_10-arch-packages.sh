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
    impala \
    neovim \
    slurp \
    wl-screenrec \
    wiremix \
    satty \
    swayosd \
    ttf-cascadia-mono-nerd \
    tldr \
    tmux \
    unzip \
    wget \
    zsh \
    zsh \
    ffmpegthumbnailer \
    mtr \
    ncdu \
    walker-bin \
    bluetui \
    blueman \
    lazygit \
    lazydocker-bin \
    zoxide
fi
