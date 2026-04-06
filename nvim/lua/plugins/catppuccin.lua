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

					-- Colors for YAML dans fichiers mdx
					-- Les clés (ex: title, draft)
					["@property.yaml"] = { fg = colors.blue, bold = true },
					["@field.yaml"] = { fg = colors.blue },

					-- Les valeurs (ton texte)
					["@string.yaml"] = { fg = colors.green },

					-- Les booléens (true / false)
					["@boolean.yaml"] = { fg = colors.peach },

					-- Les délimiteurs ( : et --- )
					["@punctuation.delimiter.yaml"] = { fg = colors.mauve },
					["@punctuation.delimiter.markdown"] = { fg = colors.mauve },

					-- On garde ça au cas où, mais le YAML passera devant
					["@keyword.directive.markdown"] = { fg = colors.blue },
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
