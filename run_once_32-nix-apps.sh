#!/usr/bin/zsh

echo "______________________"
echo "Installing Nix apps"
echo "======================"

set -e

nix profile install nixpkgs#lazydocker
nix profile install nixpkgs#microsoft-edge
nix profile install nixpkgs#vscode