return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup({
			highlight = {
				before = "",
				keyword = "bg", -- Force le fond coloré sur le mot-clé
				after = "fg",
				pattern = [[.*<(KEYWORDS)\s*:]],
			},
			-- On définit explicitement les couleurs pour Catppuccin
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#f38ba8" },
				warning = { "DiagnosticWarn", "WarningMsg", "#f9e2af" },
				info = { "DiagnosticInfo", "#89dcec" },
				hint = { "DiagnosticHint", "#94e2d5" },
				default = { "Identifier", "#cba6f7" },
			},
		})
	end,
}
