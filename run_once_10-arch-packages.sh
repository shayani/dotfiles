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
    uwsm \
    wget \
    wiremix \
    wl-screenrec \
    zsh \
    zoxide

  # pacotes necessarios para screen sharing no Hyprland
  paru -S --noconfirm --needed \
    pipewire \
    wireplumber \
    xdg-desktop-portal-hyprland
fi