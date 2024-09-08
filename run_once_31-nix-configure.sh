#!/usr/bin/zsh

echo "______________________"
echo "Configuring Nix"
echo "======================"

# Allow unfree software
nix registry add nixpkgs github:numtide/nixpkgs-unfree/nixos-unstable
