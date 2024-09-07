#!/usr/bin/zsh

echo "______________________"
echo "Installing Nix"
echo "======================"

sh <(curl -L https://nixos.org/nix/install) --no-daemon

. /home/shayani/.nix-profile/etc/profile.d/nix.sh
