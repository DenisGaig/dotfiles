-- Oil est une extension de nvim-tree qui permet de naviguer dans les dossiers avec la syntaxe de nvim
return {
	"stevearc/oil.nvim",
	dependencies = {
		{ "echasnovski/mini.icons", lazy = false },
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		local oil = require("oil")
		oil.setup({
			-- Colonnes à afficher
			columns = {
				"icon",
			},

			-- Options d'affichage
			view_options = {
				show_hidden = true, -- Montrer fichiers cachés (.env, .git, etc.)
				is_always_hidden = function(name, bufnr)
					return name == ".." or name == ".git" -- Cacher certains dossiers
				end,
			},

			-- Fenêtre flottante
			float = {
				padding = 2,
				max_width = 100,
				max_height = 30,
				border = "rounded", -- Plus joli que "none"
			},

			-- Comportement
			delete_to_trash = true, -- Sécurité : corbeille au lieu de suppression définitive
			skip_confirm_for_simple_edits = false, -- Pas de confirmation pour renommages simples
		})

		-- Keymaps
		vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Oil (flottant)" })
		vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Oil (buffer)" })
	end,
	lazy = false,
}
