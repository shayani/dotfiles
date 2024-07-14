#!/usr/bin/zsh

cowsay "Installing HomeBrew"

/bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install gcc
