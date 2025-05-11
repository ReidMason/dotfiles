-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_wayland = false

-- This is where you actually apply your config choices
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 18
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 0,
}

config.window_background_opacity = 1
config.macos_window_background_blur = 64

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.max_fps = 144

-- - { key: Backslash, mods: Super, chars: "\x1b\x5c" }

config.keys = {
	{
		key = "3",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "#" }),
	},
	-- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action.SendKey({ key = "f", mods = "ALT" }),
	},
	-- Reload wezterm config
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},
	-- Disable binds
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

-- and finally, return the configuration to wezterm
return config
