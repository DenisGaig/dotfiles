return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	config = function()
		require("todo-comments").setup({
			highlight = {
				before = "",
				keyword = "bg", -- Force le fond coloré sur le mot-clé
				after = "fg",
				comments_only = false,
				-- pattern = [[.*<(KEYWORDS)\s*:]],
			},
			-- Activer les highlights dans Telescope
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
			},
		})
	end,
}
