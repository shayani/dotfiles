local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Dracula (Official)'
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.window_decorations = 'RESIZE'

config.font = wezterm.font('Cascadia Code NF', { weight = 'Light' })
config.font_size = 13

return config
