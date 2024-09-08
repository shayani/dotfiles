#!/usr/bin/zsh

echo "______________________"
echo "Installing Nix"
echo "======================"

sh <(curl -L https://nixos.org/nix/install) --no-daemon

source ~/.nix-profile/etc/profile.d/nix.sh

# Allow unfree software
nix registry add nixpkgs github:numtide/nixpkgs-unfree/nixos-unstable
