-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 18
config.window_background_opacity = 0.8
config.macos_window_background_blur = 64
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.max_fps = 144

config.colors = {
	background = "#1c1f2b",
}

-- - { key: Backslash, mods: Super, chars: "\x1b\x5c" }

config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{
		key = "Backslash",
		mods = "CMD",
		action = wezterm.action.SendKey({ mods = "ALT", key = "\\" }),
	},
}

-- and finally, return the configuration to wezterm
return config
