#!/usr/bin/zsh

echo "______________________"
echo "Configuring Nix"
echo "======================"

source ~/.nix-profile/etc/profile.d/nix.sh

# Allow unfree software
nix registry add nixpkgs github:numtide/nixpkgs-unfree/nixos-unstable
