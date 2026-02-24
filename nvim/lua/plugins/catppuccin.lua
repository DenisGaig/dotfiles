return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			integrations = {
				todo_comments = true,
				--   cmp = false,
				--   gitsigns = true,
				--   nvimtree = true,
				--   treesitter = true,
				--   telescope = {
				--     enabled = true,
				--   },
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
