#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"

# Pega um wallpaper aleatório
WALLPAPER=$(find "$WALLPAPER_DIR" -type f 2>/dev/null | shuf -n 1)

if [[ -n "$WALLPAPER" ]]; then
  # Novo comando hyprpaper (v0.8+): hyprctl hyprpaper wallpaper <mon>,<path>
  hyprctl hyprpaper wallpaper ",$WALLPAPER" 2>/dev/null || \
    hyprctl hyprpaper reload ,"$WALLPAPER"  # fallback para versão antiga
  echo "Wallpaper: $(basename "$WALLPAPER")"
else
  echo "Nenhum wallpaper encontrado em $WALLPAPER_DIR"
  exit 1
fi
