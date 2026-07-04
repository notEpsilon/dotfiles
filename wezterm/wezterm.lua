local wezterm = require("wezterm")
local constants = require("constants")

local config = wezterm.config_builder()

config.color_scheme = "rosepine"
config.colors = require("cyberdream")
config.cursor_blink_rate = 0
config.hide_tab_bar_if_only_one_tab = true
-- config.window_decorations = "RESIZE"

config.window_background_image = constants.bg_image

config.window_padding = {
	left = 0,
	top = 0,
	right = 0,
	bottom = 0,
}

return config
