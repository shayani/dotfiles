#!/usr/bin/zsh

echo "______________________"
echo "Installing fonts"
echo "======================"

if [[ ! -f /etc/arch-release ]]; then
  echo "System is not Arch, installing fonts"
  mkdir -p ~/.local/share/fonts

  # JetBrains Mono Nerd Font
  echo "Downloading latest JetBrains Mono Nerd Font..."
  LATEST_NERD_FONT_TAG=$(curl -sL -o /dev/null -w %{url_effective} https://github.com/ryanoasis/nerd-fonts/releases/latest | rev | cut -d'/' -f1 | rev)
  wget -O /tmp/JetBrainsMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/${LATEST_NERD_FONT_TAG}/JetBrainsMono.zip"
  unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts
  rm -f /tmp/JetBrainsMono.zip

  # Cascadia Code
  echo "Downloading latest Cascadia Code..."
  LATEST_CASCADIA_TAG=$(curl -sL -o /dev/null -w %{url_effective} https://github.com/microsoft/cascadia-code/releases/latest | rev | cut -d'/' -f1 | rev)
  wget -O /tmp/CascadiaCode.zip "https://github.com/microsoft/cascadia-code/releases/download/${LATEST_CASCADIA_TAG}/CascadiaCode-${LATEST_CASCADIA_TAG#v}.zip"
  unzip -o /tmp/CascadiaCode.zip -d /tmp/CascadiaCode
  cp /tmp/CascadiaCode/ttf/*.ttf ~/.local/share/fonts/
  rm -rf /tmp/CascadiaCode /tmp/CascadiaCode.zip

  fc-cache -f -v
else
  echo "System is Arch, skipping font installation"
fi
