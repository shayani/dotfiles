#!/usr/bin/zsh

echo "______________________"
echo "Installing HomeBrew apps"
echo "======================"

set -e

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install \
  lazydocker
