#!/bin/bash

if [ -n "${XDG_CURRENT_DESKTOP}" ]; then
  /usr/bin/gsettings set org.gnome.desktop.background picture-uri file:////home/shayani/Pictures/wallpaper_meditacao.jpg  
fi

