return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"benfowler/telescope-luasnip.nvim",
		"rafamadriz/friendly-snippets",
	},
	opts = function()
		local types = require("luasnip.util.types")
		return {
			delete_check_events = "TextChanged",

			-- Insère le marqueur | dans les inlay hints
			ext_opts = {
				[types.insertNode] = {
					unvisited = {
						virt_text = { { "|", "Comment" } },
						virt_text_pos = "inline",
					},
				},
				[types.exitNode] = {
					unvisited = {
						virt_text = { { "|", "Comment" } },
						virt_text_pos = "inline",
					},
				},
				[types.choiceNode] = {
					active = {
						virt_text = { { "(snippet) choice node", "LspInlayHint" } },
					},
				},
			},
		}
	end,
	config = function(_, opts) -- ← ajout de _, opts
		local luasnip = require("luasnip")

		luasnip.setup(opts) -- ← opts passé à setup
		luasnip.filetype_extend("mdx", { "markdown", "latex" })
		luasnip.filetype_extend("markdown", { "latex" })
		luasnip.filetype_extend("typescriptreact", { "html" })
		luasnip.filetype_extend("jsx", { "html" })

		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_lua").load({
			paths = vim.fn.expand("~/.dotfiles/nvim/snippets"),
		})

		-- Keybindings pour les snippets dans telescope
		require("telescope").load_extension("luasnip")
		vim.keymap.set("n", "<leader>fs", "<cmd>Telescope luasnip<cr>", { desc = "Snippets" })
	end,
}
