#!/usr/bin/zsh

set -e

wget -O /tmp/code.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install -y /tmp/code.deb
rm /tmp/code.deb
