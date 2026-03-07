return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			presets = {
				bottom_search = false,
				lsp_doc_border = true,
			},
			messages = {
				enabled = true,
				view = "mini", -- style mini discret
				view_error = "notify",
				view_warn = "notify",
			},
			notify = {
				enabled = true,
				-- view = "mini",
			},
			lsp = {
				message = {
					enabled = true,
					view = "notify",
				},
			},
			views = {
				cmdline_popup = {
					position = {
						row = "40%",
						col = "50%",
					},
				},
				mini = {
					timeout = 5000, -- timeout in milliseconds
					align = "center",
					position = {
						-- Centers messages top to bottom
						row = "95%",
						-- Aligns messages to the far right
						col = "100%",
					},
				},
			},
		})

		-- Configuration de nvim-notify (le moteur visuel)
		require("notify").setup({
			background_colour = "#000000",
			stages = "fade_in_slide_out", -- Animation fluide
			render = "default", -- "default" ajoute les bordures et l'icône. "compact" est plus minimaliste.
			timeout = 5000,
			top_down = false, -- IMPORTANT : Force l'apparition des notifications en BAS
		})
	end,
}
