#!/usr/bin/zsh

cowsay "Installing HomeBrew apps"

set -e

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install \
  chezmoi \
  lazydocker \
  withgraphite/tap/graphite

# /home/linuxbrew/.linuxbrew/bin/brew install lazydocker
