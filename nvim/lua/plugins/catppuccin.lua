return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			custom_highlights = function(colors)
				return {
					htmlBold = { fg = "#f39c16", bold = true },
					htmlItalic = { fg = colors.pink, italic = true },
					htmlBoldItalic = { fg = colors.pink, bold = true, italic = true },
				}
			end,
			transparent_background = true,
			integrations = {
				todo_comments = true,
				--   cmp = false,
				--   gitsigns = true,
				--   nvimtree = true,
				--   treesitter = true,
				-- telescope = {
				-- 	enabled = true,
				-- },
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

-- Pour info: couleurs de Catppuccin
-- {
--   base = "#1e1e2f",
--   blue = "#89b4fb",
--   crust = "#11111c",
--   flamingo = "#f2cdce",
--   green = "#a6e3a2",
--   lavender = "#b4beff",
--   mantle = "#181826",
--   maroon = "#eba0ad",
--   mauve = "#cba6f8",
--   overlay0 = "#6c7087",
--   overlay1 = "#7f849d",
--   overlay2 = "#9399b3",
--   peach = "#fab388",
--   pink = "#f5c2e8",
--   red = "#f38ba9",
--   rosewater = "#f5e0dd",
--   sapphire = "#74c7ed",
--   sky = "#89dcec",
--   subtext0 = "#a6adc9",
--   subtext1 = "#bac2df",
--   surface0 = "#313245",
--   surface1 = "#45475b",
--   surface2 = "#585b71",
--   teal = "#94e2d6",
--   text = "#cdd6f5",
--   yellow = "#f9e2b0"
-- }
