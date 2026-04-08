-- ~/.config/nvim/lua/plugins/luasnip.lua
return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"benfowler/telescope-luasnip.nvim",
		"rafamadriz/friendly-snippets", -- snippet de blink-cmp
	},
	config = function()
		local luasnip = require("luasnip")
		luasnip.filetype_extend("mdx", { "markdown" })
		-- Charge les snippets friendly-snippets (VSCode style)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Charge tes snippets custom dans ~/.dotfiles/nvim/snippets/
		require("luasnip.loaders.from_lua").load({
			paths = vim.fn.expand("~/.dotfiles/nvim/snippets"),
		})

		-- Enregistre l'extension telescope-luasnip
		require("telescope").load_extension("luasnip")

		-- Blink gère Tab/S-Tab pour la navigation dans les snippets
		-- On garde uniquement le picker Telescope

		-- ; en mode normal → picker Telescope des snippets du filetype courant
		vim.keymap.set("n", ";", "<cmd>Telescope luasnip<cr>", { desc = "Snippets" })
	end,
}
