#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
CACHE_FILE="/tmp/last-wallpaper.txt"

# Lê o wallpaper anterior
PREVIOUS=""
[[ -f "$CACHE_FILE" ]] && PREVIOUS=$(cat "$CACHE_FILE")

# Escolhe um wallpaper aleatório, excluindo o atual se possível
if [[ -n "$PREVIOUS" ]]; then
  WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -wholename "$PREVIOUS" 2>/dev/null | shuf -n 1)
fi

# Se não conseguiu (ex: PREVIOUS vazio, ou única imagem), pega qualquer um
if [[ -z "$WALLPAPER" ]]; then
  WALLPAPER=$(find "$WALLPAPER_DIR" -type f 2>/dev/null | shuf -n 1)
fi

if [[ -n "$WALLPAPER" ]]; then
  # Salva antes de aplicar
  echo "$WALLPAPER" > "$CACHE_FILE"
  # Novo comando hyprpaper (v0.8+)
  hyprctl hyprpaper wallpaper ",$WALLPAPER" 2>/dev/null || \
    hyprctl hyprpaper reload ,"$WALLPAPER"  # fallback para versão antiga
  echo "Wallpaper: $(basename "$WALLPAPER")"
else
  echo "Nenhum wallpaper encontrado em $WALLPAPER_DIR"
  exit 1
fi
