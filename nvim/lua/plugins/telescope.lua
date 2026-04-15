return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- fzf native en C meilleur que celui de lua
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				-- Configuration de l'interface
				defaults = {
					layout_strategy = "bottom_pane",
					layout_config = {
						height = 0.4,
						preview_width = 0.4,
					},
					border = true,
					sorting_strategy = "ascending",
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
			-- require("telescope").load_extension("yank_history")

			-- 🔑 Liste des raccourcis
			local builtin = require("telescope.builtin")
			-- vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })
			-- vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			-- vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			-- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			-- vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp_tags" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			-- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>sT", builtin.builtin, { desc = "[S]earch select [T]elescope" })
			vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "[S]earch [T]ODOs" })
			-- vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			-- vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			-- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- vim.keymap.set("n", "<leader>sy", "<cmd>Telescope yank_history<cr>", { desc = "[S]earch [Y]ank history" })

			-- 🔑 Ouvre un picker sur le contenu du buffer actuel pour effectuer une recherche
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- 🔑 Recherche dans les fichiers ouverts
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- 🔑 Recherche des fichiers de configuration de Neovim
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })

			-- 🔑 Recherche multi-grep
			vim.keymap.set("n", "<leader>fg", require("denis.multigrep"), { desc = "Multi Grep" })

			-- =========================================================
			-- 🔑 RECHERCHE DE TÂCHES MARKDOWN
			-- <leader>tt : tâches en cours (- [ ])
			-- <leader>tc : tâches complétées (- [x])
			-- =========================================================

			local function search_tasks(done)
				-- local builtin = require("telescope.builtin")
				builtin.grep_string({
					prompt_title = done and "Tâches complétées" or "Tâches en cours",
					search = done and "- [x]" or "- [ ]", -- Sans regex, texte littéral
					use_regex = false,
					glob_pattern = "*.md",
				})
			end
			vim.keymap.set("n", "<leader>tt", function()
				search_tasks(false)
			end, { desc = "Lister tâches en cours" })

			vim.keymap.set("n", "<leader>tc", function()
				search_tasks(true)
			end, { desc = "Lister tâches complétées" })
		end,
	},
	{
		-- Plugin qui permet à Telescope de remplacer les menus natifs de Neovim par une interface Telescope
		"nvim-telescope/telescope-ui-select.nvim",
	},
}
