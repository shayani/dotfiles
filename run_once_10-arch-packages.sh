#!/bin/bash

# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Using Arch"
  paru -S --noconfirm --needed \
    blueman \
    bluetui \
    btop \
    dmenu \
    fd \
    ffmpegthumbnailer \
    fish \
    fontconfig \
    fzf \
    git \
    github-cli \
    gnome-keyring \
    impala \
    lazydocker-bin \
    lazygit \
    libgnome-keyring \
    libnewt \
    libsecret \
    mise \
    mtr \
    ncdu \
    neovim \
    npm \
    postgresql-libs \
    pulsemixer \
    satty \
    seahorse \
    slurp \
    swayosd \
    tldr \
    tmux \
    ttf-cascadia-mono-nerd \
    ttf-jetbrains-mono-nerd \
    unzip \
    uwsm \
    walker-bin \
    watchman-bin \
    wavemon \
    wget \
    wiremix \
    wl-screenrec \
    zoxide \
    zsh

  # pacotes necessarios para screen sharing no Hyprland
  paru -S --noconfirm --needed \
    pipewire \
    wireplumber \
    xdg-desktop-portal-hyprland
fi
