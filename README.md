# Instruções

## Pré-requisito

O usuário deve ter permissão de `sudo`.

### Instalação de um usuário padrão

```
apt install -y curl git sudo
adduser shayani
usermod -aG sudo shayani
```

### Instalação de pré-requisitos do Chezmoi

```
sudo apt install -y curl git
sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
```

## Chezmoi

```
chezmoi init --apply shayani
```
