#!/usr/bin/zsh

echo "______________________"
echo "Installing HomeBrew apps"
echo "======================"

set -e

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install \
  lazydocker \
  withgraphite/tap/graphite

# /home/linuxbrew/.linuxbrew/bin/brew install lazydocker
