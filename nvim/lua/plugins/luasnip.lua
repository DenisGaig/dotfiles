-- ~/.config/nvim/lua/plugins/luasnip.lua
return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"benfowler/telescope-luasnip.nvim",
	},
	config = function()
		local luasnip = require("luasnip")

		-- Charge les snippets friendly-snippets (VSCode style)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Charge tes snippets custom dans ~/.dotfiles/nvim/snippets/
		require("luasnip.loaders.from_lua").load({
			paths = vim.fn.expand("~/.dotfiles/nvim/snippets"),
		})

		-- Enregistre l'extension telescope-luasnip
		require("telescope").load_extension("luasnip")

		-- Navigation entre les champs du snippet avec Tab / Shift-Tab
		vim.keymap.set({ "i", "s" }, "<Tab>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { silent = true })

		-- ; en mode normal → picker Telescope des snippets du filetype courant
		vim.keymap.set("n", ";", "<cmd>Telescope luasnip<cr>", { desc = "Snippets" })
	end,
}
