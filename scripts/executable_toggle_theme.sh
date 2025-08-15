#!/bin/bash

# --- Personalize seus temas aqui ---
LIGHT_THEME="Adwaita"
DARK_THEME="Adwaita-dark"
# ------------------------------------

# A lógica agora é baseada no 'color-scheme', que é mais confiável.
# Os valores podem ser 'default', 'prefer-dark', 'prefer-light'.
CURRENT_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

# Verifica se o esquema atual prefere o escuro
if [[ "$CURRENT_SCHEME" == *'prefer-dark'* ]]; then
  # Se for escuro, muda para o claro
  gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_THEME"
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  echo "Tema alterado para o modo claro ($LIGHT_THEME)."
else
  # Se for claro ou padrão, muda para o escuro
  gsettings set org.gnome.desktop.interface gtk-theme "$DARK_THEME"
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  echo "Tema alterado para o modo escuro ($DARK_THEME)."
fi