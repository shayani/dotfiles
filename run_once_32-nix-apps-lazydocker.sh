#!/usr/bin/zsh

echo "Installing Lazydocker"
echo "======================"

set -e

nix profile install nixpkgs#lazydocker