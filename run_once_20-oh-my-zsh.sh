#!/bin/bash

set -e
echo "______________________"
echo "Installing Oh-my-zsh"
echo "======================"

rm -rf ~/.oh-my-zsh
sh -c "ZSH= $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sudo chsh -s /usr/bin/zsh shayani
