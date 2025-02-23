# # Alt+F4 is very cumbersome
dconf write /org/gnome/desktop/wm/keybindings/close "['<Super>w']"

# # Make it easy to maximize like you can fill left/right
dconf write /org/gnome/desktop/wm/keybindings/maximize "['<Super>Up']"

# # Make it easy to resize undecorated windows
# dconf write /org/gnome/desktop/wm/keybindings/begin-resize "['<Super>BackSpace']"

# # For keyboards that only have a start/stop button for music, like Logitech MX Keys Mini
dconf write /org/gnome/settings-daemon/plugins/media-keys/next "['<Shift>AudioPlay']"

# # Full-screen with title/navigation bar
# dconf write /org/gnome/desktop/wm/keybindings/toggle-fullscreen "['<Shift>F11']"

# # Use 4 fixed workspaces instead of dynamic mode
dconf write /org/gnome/mutter/dynamic-workspaces "false"
dconf write /org/gnome/desktop/wm/preferences/num-workspaces "4"

# # Use alt for pinned apps
# dconf write /org/gnome/shell/keybindings/switch-to-application-1 "['<Alt>1']"
# dconf write /org/gnome/shell/keybindings/switch-to-application-2 "['<Alt>2']"
# dconf write /org/gnome/shell/keybindings/switch-to-application-3 "['<Alt>3']"
# dconf write /org/gnome/shell/keybindings/switch-to-application-4 "['<Alt>4']"
# dconf write /org/gnome/shell/keybindings/switch-to-application-5 "['<Alt>5']"
# dconf write /org/gnome/shell/keybindings/switch-to-application-6 "['<Alt>6']"
# dconf write /org/gnome/shell/keybindings/switch-to-application-7 "['<Alt>7']"
# dconf write /org/gnome/shell/keybindings/switch-to-application-8 "['<Alt>8']"
# dconf write /org/gnome/shell/keybindings/switch-to-application-9 "['<Alt>9']"

# # Use super for workspaces
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-1 "['<Shift><Super>1']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-2 "['<Shift><Super>2']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-3 "['<Shift><Super>3']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-4 "['<Shift><Super>4']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>1']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>2']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>3']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>4']"
# dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-5 "['<Super>5']"
# dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-6 "['<Super>6']"

# # Reserve slots for custom keybindings
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/']"

# # Set ulauncher to Super+Space
# dconf write /org/gnome/desktop/wm/keybindings/switch-input-source "@as []"
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'ulauncher-toggle'"
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'ulauncher-toggle'"
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Super>space'"

# # Set flameshot (with the sh fix for starting under Wayland) on alternate print screen key
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/name "'Flameshot'"
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/command "'sh -c -- \"flameshot gui\"'"
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/binding "'<Control>Print'"

# Extensões
echo "Extensões úteis"
echo "Caffeine - https://github.com/eonpatapon/gnome-shell-extension-caffeine"
echo "Clipboard Indicator - https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator"
echo "Notification Banner Reloaded - https://github.com/marcinjakubowski/notification-position-reloaded"
echo "App Icons Taskbar - https://gitlab.com/AndrewZaech/aztaskbar"
