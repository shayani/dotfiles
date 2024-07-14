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
```

## Chezmoi

```
sh -c "$(curl -fsLS get.chezmoi.io)"
bin/chezmoi init --apply shayani
```
