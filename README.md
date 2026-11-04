# Dotfiles

Configurações pessoais gerenciadas com [chezmoi](https://www.chezmoi.io).
Repositório: `git@github.com:shayani/dotfiles.git`

## Máquina nova

### 1. Pré-requisitos

**macOS**

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi
```

**Debian / Ubuntu**

```sh
sudo apt update
sudo apt install -y curl git sudo
sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
```

Se o usuário ainda não existir:

```sh
adduser shayani
usermod -aG sudo shayani
```

**Fedora**

```sh
sudo dnf install -y curl git sudo
sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
```

Usuário novo: `adduser shayani` + `usermod -aG wheel shayani`.

### 2. Aplicar

```sh
chezmoi init --apply shayani
```

Na primeira execução o chezmoi:

1. clona este repositório em `~/.local/share/chezmoi`;
2. gera `~/.config/chezmoi/chezmoi.toml` a partir de `.chezmoi.toml.tmpl`;
3. pede a passphrase da chave `age` e decifra os secrets;
4. instala os pacotes do sistema (`run_onchange_install-packages.sh.tmpl`).

## Pacotes do sistema

| SO | Como |
|---|---|
| macOS | `.Brewfile` via `brew bundle` |
| Debian / Ubuntu | lista no script, via `apt` |
| Fedora | lista no script, via `dnf` |

O script é `run_onchange_`: só roda de novo quando o próprio script ou o
`.Brewfile` mudam (o hash do Brewfile está embutido no script). Para forçar:

```sh
chezmoi state delete-bucket --bucket=scriptState && chezmoi apply
```

Pacotes que não estão nos repositórios da distro (ex.: `zellij` no Debian,
`lazydocker`) são pulados com aviso — instale à mão se precisar.

## O que é específico de cada SO

O `.chezmoiignore` controla isso:

- **macOS**: `~/.aerospace.toml` e os casks do `.Brewfile`;
- **Linux**: `~/.XCompose`, `~/.config/{hypr,i3,mako,matugen,solaar,sway,swayosd,walker,waybar,wlogout,wofi}` e `~/scripts`;
- **ambos**: kitty, nvim, tmux, zellij, fish, zsh, opencode, gh, git, pi, nix.

## Uso diário

```sh
chezmoi status   # diferenças entre máquina e repositório
chezmoi diff     # o que seria aplicado
chezmoi update   # git pull + apply
chezmoi re-add   # traz mudanças da máquina para o repositório
chezmoi cd       # entra no repositório para commitar
```
