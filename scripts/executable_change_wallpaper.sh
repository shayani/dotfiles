#!/bin/bash

WALLPAPER_DIR="/home/shayani/Pictures/wallpapers"
CURRENT_WALLPAPER=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper from the directory
NEW_WALLPAPER=$(ls $WALLPAPER_DIR | shuf -n 1)

# Apply wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER_DIR/$NEW_WALLPAPER"
matugen image --type scheme-expressive "$WALLPAPER_DIR/$NEW_WALLPAPER"

