#!/usr/bin/zsh

echo "______________________"
echo "Installing Nix"
echo "======================"

sh <(curl -L https://nixos.org/nix/install) --daemon --yes
