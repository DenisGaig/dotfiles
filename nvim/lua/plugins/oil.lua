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

			float = {
				padding = 2,
				max_width = 60, -- Réduit pour être plus "slim" (style sidebar)
				max_height = 20, -- Réduit un peu pour ne pas prendre tout l'écran
				border = "rounded",

				-- C'est ici que la magie opère pour le positionnement
				override = function(conf)
					-- On s'assure que la position est relative à l'éditeur entier
					conf.relative = "editor"

					-- On place la fenêtre tout en haut (row = 0)
					-- et à droite (col = largeur écran - largeur fenêtre - marge)
					conf.row = 0
					conf.col = vim.o.columns - conf.width - 2 -- Le -2 ajoute une petite marge à droite

					return conf
				end,
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
