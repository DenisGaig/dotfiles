---@diagnostic disable: undefined-global
-- =============================================================================
-- theme.lua
-- Syntaxe couleur dégradé : { colors = {"rgba(...)", "rgba(...)"}, angle = 45 }
-- Source : exemple officiel hyprwm/Hyprland
-- =============================================================================

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 0.85,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	group = {
		col = {
			border_active = { colors = { "rgb(BB9AF7)", "rgb(7AA2F7)", "rgb(41A6B5)" }, angle = 45 },
		},
		groupbar = {
			font_size = 12,
			indicator_height = 0,
			height = 20,
			gradients = true,
			text_color = "rgb(C0CAF5)",
			col = {
				active = "rgb(2f3344)",
				inactive = "rgba(2f334466)",
			},
			gaps_in = 0,
			gaps_out = 0,
		},
	},
})
