---@diagnostic disable: undefined-global
-- =============================================================================
-- hyprland.lua — Config principale
-- Basé sur l'exemple officiel hyprwm/Hyprland (v0.55+)
-- =============================================================================

require("monitors")
require("theme")
require("animations")
require("windowrules")
require("keybindings")

-- =============================================================================
-- ENVIRONMENT VARIABLES
-- =============================================================================

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "McMojave")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")

-- =============================================================================
-- CONFIG GÉNÉRALE
-- =============================================================================

hl.config({
	cursor = {
		no_hardware_cursors = 2,
	},
	misc = {
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},

	-- LAYOUTS --
	dwindle = {
		preserve_split = true,
		force_split = 2,
	},
	master = {
		new_status = "slave",
		orientation = "left",
	},
	scrolling = {
		fullscreen_on_one_column = true,
	},

	input = {
		kb_layout = "fr",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:escape", -- Remappement clavier Majuscule en CTRL
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- =============================================================================
-- DEVICE
-- =============================================================================

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

-- =============================================================================
-- AUTOSTART
-- =============================================================================

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("~/.dotfiles/hypr/scripts/random-wallpaper.sh")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("wlsunset -l 48.8666 -L 2.33 -t 4500 -T 6000")
	hl.exec_cmd("env QT_QPA_PLATFORM=wayland keepassxc")
	hl.exec_cmd("~/.config/hypr/scripts/battery-notify.sh")
	hl.exec_cmd("~/.config/hypr/scripts/startup.sh")
end)
