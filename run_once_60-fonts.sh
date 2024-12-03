#!/usr/bin/zsh

echo "______________________"
echo "Installing fonts"
echo "======================"

mkdir -p ~/.local/share/fonts

# JetBrains Mono
wget -O /tmp/JetBrainsMono.zip https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip
unzip /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono
cp /tmp/JetBrainsMono/fonts/ttf/*.ttf ~/.local/share/fonts/
rm -rf /tmp/JetBrainsMono

# Cascadia Code
wget -O /tmp/CascadiaCode.zip https://github.com/microsoft/cascadia-code/releases/download/v2404.23/CascadiaCode-2404.23.zip
unzip /tmp/CascadiaCode.zip -d /tmp/CascadiaCode
cp /tmp/CascadiaCode/ttf/*.ttf ~/.local/share/fonts/
rm -rf /tmp/CascadiaCode

fc-cache -f -v
