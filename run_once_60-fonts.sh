#!/bin/bash

sudo apt install -y fontconfig

# JetBrains Mono
wget -O /tmp/JetBrainsMono.zip https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip
unzip /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono
mkdir -p ~/.local/share/fonts
cp /tmp/JetBrainsMono/fonts/ttf/*.ttf ~/.local/share/fonts/
fc-cache -f -v
rm -rf /tmp/JetBrainsMono
