# AI Instructions

## Sistema Operacional
- **Distro**: Arch Linux
- **Gerenciadores de pacote**: pacman e paru
- **Regra importante**: Sempre usar `--noconfirm` com pacman e paru

## Comandos do Sistema
```bash
# Instalação de pacotes
sudo pacman -S --noconfirm <pacote>
paru -S --noconfirm <pacote>

# Remoção de pacotes
sudo pacman -Rns --noconfirm <pacote>
paru -Rns --noconfirm <pacote>
```

## Preferências Gerais
- Usar português nas respostas
- Não pedir confirmação para operações com pacman/paru
- Ser direto e conciso nas respostas

## Desenvolvimento
- Sempre verificar se há comandos de lint/test antes de finalizar tarefas
- Seguir convenções existentes no projeto

## Notas
- Este arquivo deve ser lido antes de executar ações importantes
- Atualizar conforme necessário