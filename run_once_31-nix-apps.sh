#!/usr/bin/zsh

echo "______________________"
echo "Installing Nix apps"
echo "======================"

set -e

nix-env -iA nixpkgs.lazydocker
