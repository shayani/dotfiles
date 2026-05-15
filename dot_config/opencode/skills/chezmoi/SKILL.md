---
name: chezmoi
description: >-
  Use quando o usuário pedir para atualizar, commitar, ou sincronizar arquivos
  gerenciados pelo chezmoi. Inclui criptografar secrets, verificar estado do
  chezmoi, fazer commit e push dos dotfiles.
---

# Chezmoi

- Repositório: `~/.local/share/chezmoi`
- Remote: `git@github.com:shayani/dotfiles.git`

## Fluxo

1. **Criptografe secrets** — Se o arquivo contiver chaves de API, tokens,
   senhas ou qualquer informação sigilosa, use `chezmoi encrypt <arquivo>`
   (ou crie como `encrypted_<nome>.age`) em vez de salvar o conteúdo em
   texto puro.

2. **Atualize o source** — Copie/atualize o arquivo correspondente em
   `~/.local/share/chezmoi/`. Use `chezmoi source-path <arquivo>` para
   descobrir o path no source se necessário.

3. **Verifique pendências do chezmoi** — Antes de commitar, rode:
   ```bash
   chezmoi update  # puxa mudanças do remote e aplica
   chezmoi status  # mostra diferenças source vs destino
   ```
   Se houver algo fora do esperado, avise o usuário.

4. **Faça diff** — Rode `git -C ~/.local/share/chezmoi diff` para revisar
   as mudanças.

5. **Commit e push** — Rode `git add`, `git commit`, `git push` no
   repositório chezmoi. Mensagens de commit em português, concisas.

## Notas

- Quando o usuário pedir para "atualizar o chezmoi" com um arquivo ou
  configuração, já está implícito que deve fazer commit e push.
- Sempre leia o arquivo existente no source do chezmoi antes de sobrescrever.
