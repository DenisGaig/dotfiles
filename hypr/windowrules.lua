---@diagnostic disable: undefined-global
-- =============================================================================
-- windowrules.lua
-- Corrections depuis l'exemple officiel :
--   - `pin` (pas `pinned`) dans match
--   - `no_focus = true` (pas `focus = true`)
--   - suppression des champs inexistants
-- =============================================================================

-- Ignore maximize requests
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix dragging XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false, -- corrigé : était `pinned`
	},
	no_focus = true, -- corrigé : était `focus = true`
})

-- Thunar
hl.window_rule({
	match = { class = "thunar" },
	float = true,
	size = { 800, 650 },
	center = true,
})

-- SpeedCrunch
hl.window_rule({
	match = { title = "SpeedCrunch" },
	float = true,
	size = { 600, 300 },
	center = true,
})

-- xdg-desktop-portal-gtk
hl.window_rule({
	match = { class = "xdg-desktop-portal-gtk" },
	float = true,
	size = { 1150, 650 },
	center = true,
})

-- skitty-notes
hl.window_rule({
	match = { class = "skitty-notes" },
	float = true,
	size = { 350, 500 },
	move = { 990, 120 },
})

-- rofidex-capture
hl.window_rule({
	match = { class = "rofidex-capture" },
	float = true,
	size = { 900, 600 },
	center = true,
})

-- =============================================================================
-- WORKSPACE PAR APPLICATION
-- =============================================================================

hl.window_rule({ match = { class = "dev.zed.Zed" }, workspace = "1" })
hl.window_rule({ match = { class = "brave-browser" }, workspace = "3" })
hl.window_rule({ match = { class = "Alacritty" }, workspace = "4" })
hl.window_rule({
	match = { class = "Claude" },
	workspace = "5",
	opacity = "0.95 override 0.94 override",
})
hl.window_rule({ match = { class = "obsidian" }, workspace = "6" })
hl.window_rule({ match = { class = "org.gnome.Geary" }, workspace = "7" })
hl.window_rule({ match = { class = "brave-music.youtube.com__-Default" }, workspace = "8" })
hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" }, workspace = "9" })
