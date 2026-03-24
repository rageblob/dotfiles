--------------------------------------------------------------------
--  WezTerm init.lua – converted from your Kitty config
--------------------------------------------------------------------
local wezterm = require("wezterm")

--------------------------------------------------------------------
-- Window size & look & feel
--------------------------------------------------------------------
local config = {
	-- Initial window size (in characters)
  initial_cols = 80,
  initial_rows = 24,

	-- WezTerm does not expose a “border width” setting; we mimic a thin border
	-- with window padding.  The value is expressed in points.
	window_padding = {
		left = "2.5pt",
		right = "2.5pt",
		top = "2.5pt",
		bottom = "2.5pt",
	},

	-- Background opacity / blur
	window_background_opacity = 0.975,
	macos_window_background_blur = 20,

  -- Hide window decorations but keep window reiszable
  -- https://wezterm.org/config/lua/config/window_decorations.html?h=decoratio#window_decorations-title-resize
	window_decorations = "RESIZE",

	-- Hide the tab bar when there is only one tab (roughly like hide_window_decorations yes)
	hide_tab_bar_if_only_one_tab = true,

	-- Window frame (title bar) colour – kitty’s active_border_color orange
	window_frame = {
		font = wezterm.font("JetBrainsMono Nerd Font Mono"),
		font_size = 14,
		active_titlebar_bg = "#ff8000", -- orange
		inactive_titlebar_bg = "#444444", -- a dark grey
		-- Note: we can only set title‑bar colours; actual window borders are
		-- handled by the OS window manager.
	},

	-- Fonts
	font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font Mono" }),
	font_size = 14.0,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- keeps the font “auto” behaviour
}

--------------------------------------------------------------------
-- Key bindings – everything that used to live under `map`
--------------------------------------------------------------------
config.key_tables = {
	default = {
		--------------------------------------------------------------------
		-- Text movement / editing (Super = Cmd on macOS)
		--------------------------------------------------------------------
		{ key = "Backspace", mods = "SUPER", action = wezterm.action({ SendString = "\x15" }) }, -- Cmd+Backspace → Ctrl+U
		{ key = "Delete", mods = "SUPER", action = wezterm.action({ SendString = "\x0B" }) }, -- Cmd+Fn+Backspace → Ctrl+K
		{ key = "LeftArrow", mods = "SUPER", action = wezterm.action({ SendString = "\x01" }) }, -- Cmd+Left → Ctrl+A
		{ key = "RightArrow", mods = "SUPER", action = wezterm.action({ SendString = "\x05" }) }, -- Cmd+Right → Ctrl+E

		--------------------------------------------------------------------
		-- Reset layout (Super+Shift+R)
		--------------------------------------------------------------------
		-- {key="R", mods="SUPER|SHIFT", action=wezterm.action{ResetLayout={}}},

		--------------------------------------------------------------------
		-- Tab management
		--------------------------------------------------------------------
		-- {key="Left",   mods="SUPER|ALT",  action=wezterm.action{ActivateTabRelative=-1}},
		-- {key="Right",  mods="SUPER|ALT",  action=wezterm.action{ActivateTabRelative=1}},
		-- {key="R",      mods="SUPER|ALT",  action=wezterm.action{SetTabTitle=true}},
		-- {key="Left",   mods="SHIFT|SUPER|ALT", action=wezterm.action{MoveTab=-1}},
		-- {key="Right",  mods="SHIFT|SUPER|ALT", action=wezterm.action{MoveTab=1}},

		--------------------------------------------------------------------
		-- Split windows / new tabs
		--------------------------------------------------------------------
		{ key = "t", mods = "SUPER|SHIFT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
		{ key = "h", mods = "CTRL|ALT|SUPER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
		{ key = "v", mods = "CTRL|ALT|SUPER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{ key = ".", mods = "CTRL|ALT|SUPER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	},
}

config.color_scheme = "One Dark (Gogh)"

return config
