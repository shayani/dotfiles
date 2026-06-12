---
name: configurar-fontes
description: >-
  Use quando o usuário pedir para instalar, configurar ou trocar fontes Nerd
  Font entre Kitty, WezTerm, VSCode e Cursor. Inclui instalação via Homebrew,
  ajuste de peso (Thin/ExtraLight/Light/Regular), tamanho e ligaduras.
---

# Configurar Fontes

## Instalação via Homebrew

```bash
brew install font-<nome>-nerd-font
```

Exemplos comuns:
- `font-cascadia-code-nf` — Cascadia Code NF (da Microsoft)
- `font-iosevka-nerd-font` — Iosevka (padrão)
- `font-iosevka-term-nerd-font` — Iosevka (narrow, ideal pra terminal)
- `font-monofur-nerd-font` — Monofur (estilo retrô)
- `font-mononoki-nerd-font` — Mononoki (divertida)
- `font-envy-code-r-nerd-font` — Envy Code R (compacta)
- `font-terminess-ttf-nerd-font` — Terminus TTF (bem compacta)
- `font-jetbrains-mono-nerd-font` — JetBrains Mono
- `font-caskaydia-cove-nerd-font` — Caskaydia Cove (Cascadia renomeada)
- `font-victor-mono-nerd-font` — Victor Mono (itálico cursivo)
- `font-blex-mono-nerd-font` — Blex Mono (IBM Plex Mono)

## Pesos disponíveis

Para ver os pesos de uma fonte:

```bash
fc-list -f "%{postscriptname} : %{style}\n" | grep -i "<nome>" | sort
```

Mapeamento de pesos:
- Nerd Font `Thin` → CSS `100`
- Nerd Font `ExtraLight` → CSS `200`
- Nerd Font `Light` → CSS `300`
- Nerd Font `Regular` → CSS `400`
- Nerd Font `Medium` → CSS `500`
- Nerd Font `SemiBold` → CSS `600`
- Nerd Font `Bold` → CSS `700`

## Ligaduras (Cascadia Code)

Para ativar ligaduras no VSCode/Cursor:

```json
"editor.fontLigatures": "'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss19', 'ss20'"
```

## Configuração por app

### Kitty (`~/.config/kitty/kitty.conf`)

```conf
font_family      Cascadia Code NF
font_style       Light
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        12.0
```

Ou usando nome PostScript direto:
```conf
font_family      IosevkaNF-ExtraLight
bold_font        IosevkaNF-Bold
italic_font      IosevkaNF-Italic
bold_italic_font IosevkaNF-BoldItalic
```

Recarregar: `kitty @ reload-config` (prefira restart completo).

### WezTerm (`~/.config/wezterm/wezterm.lua`)

```lua
config.font = wezterm.font('Cascadia Code NF', { weight = 'Light' })
config.font_size = 12
```

### VSCode / Cursor (`settings.json`)

```json
{
  "editor.fontFamily": "'Cascadia Code NF', 'JetBrainsMono Nerd Font', monospace",
  "editor.fontWeight": "300",
  "editor.fontSize": 14,
  "editor.fontLigatures": "'calt', 'liga'",
  "terminal.integrated.fontFamily": "'Cascadia Code NF'",
  "terminal.integrated.fontWeight": "300",
  "terminal.integrated.fontSize": 12
}
```

- VSCode: `~/Library/Application Support/Code/User/settings.json`
- Cursor: `~/Library/Application Support/Cursor/User/settings.json`

## Ajustes para monitores não-Retina (82 PPI)

Para monitores como o Samsung Odyssey G30 (27" 1080p, ~82 PPI):

- **Hinting**: `hintslight` é o ponto ideal. Para mais definição, `hintfull`.
- **Tamanhos**: terminal 12, editor 14 — ajustar conforme preferência.
- Ligaduras específicas de cada fonte (ex: `ss01`, `ss19` da Cascadia) podem
  não funcionar em outras fontes. Prefira `'calt', 'liga'` como padrão.
- No macOS o hinting é controlado pelo CoreText, não exposto nas configs
  dos apps. As configurações de hinting se aplicam a Linux/Windows.

Ambos podem ser gerenciados pelo chezmoi.

## Chezmoi

`~/.config/kitty/kitty.conf` é gerenciado pelo chezmoi em
`~/.local/share/chezmoi/dot_config/kitty/kitty.conf`.

Sempre alterar pelo source e aplicar:
```bash
chezmoi apply ~/.config/kitty/kitty.conf
```

Para adicionar um arquivo ao chezmoi:
```bash
chezmoi add ~/.config/wezterm/wezterm.lua
```

## Fontes favoritas do usuário

1. **SpaceMono Nerd Font** — atual, aprovada
2. **Cascadia Code NF** — usou por um bom tempo
3. **JetBrainsMono Nerd Font** — pré-existente, reserva
4. **Monofur Nerd Font** — testou, curtiu o estilo único

Preferências consolidadas: Regular 400, tamanho 12 em todos os apps.
Samsung Odyssey G30 (27" 1080p, ~82 PPI).

