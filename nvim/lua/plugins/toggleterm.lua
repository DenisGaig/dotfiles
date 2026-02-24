return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
		})

		-- Fonction pour définir les keymaps dans les terminaux
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0, noremap = true, silent = true }

			-- Sortir du mode INSERT terminal (reste dans le terminal en mode NORMAL)
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jj", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)

			-- Fermer le terminal avec q en mode NORMAL (dans le terminal)
			vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
		end

		-- Appliquer automatiquement les keymaps à tous les terminaux
		vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

		-- ============ TERMINAUX DEDIES (usage ponctuel) =======================

		local Terminal = require("toggleterm.terminal").Terminal

		-- Terminal pour LazyGit

		-- local lazygit = Terminal:new({
		--   cmd = "lazygit",
		--   hidden = true,
		--   direction = "float",
		-- })
		--
		-- function _LAZYGIT_TOGGLE()
		--   lazygit:toggle()
		-- end
		--
		-- Terminal pour Node REPL
		local node = Terminal:new({
			cmd = "node",
			hidden = true,
			direction = "float",
		})

		function _NODE_TOGGLE()
			node:toggle()
		end

		-- Terminal pour Python REPL
		local python = Terminal:new({
			cmd = "python",
			hidden = true,
			direction = "float",
		})

		function _PYTHON_TOGGLE()
			python:toggle()
		end

		-- Terminal pour htop
		local htop = Terminal:new({
			cmd = "btop",
			hidden = true,
			direction = "float",
		})

		function _HTOP_TOGGLE()
			htop:toggle()
		end

		-- Fonction pour exécuter le fichier courant
		function _RUN_CURRENT_FILE()
			local file_ext = vim.fn.expand("%:e")
			local file_name = vim.fn.expand("%:t")
			local cmd = ""

			if file_ext == "py" then
				cmd = "python " .. file_name
			elseif file_ext == "js" then
				cmd = "node " .. file_name
			elseif file_ext == "sh" then
				cmd = "bash " .. file_name
			else
				vim.notify("Type de fichier non supporté: " .. file_ext, vim.log.levels.WARN)
				return
			end

			local run_term = Terminal:new({
				cmd = cmd,
				direction = "horizontal",
				close_on_exit = false,
			})
			run_term:toggle()
		end

		-- ========== KEYMAPS ==========

		-- Terminaux dédiés ponctuels
		-- vim.keymap.set("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "LazyGit", noremap = true, silent = true })
		vim.keymap.set(
			"n",
			"<leader>tn",
			"<cmd>lua _NODE_TOGGLE()<CR>",
			{ desc = "Node REPL", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>tp",
			"<cmd>lua _PYTHON_TOGGLE()<CR>",
			{ desc = "Python REPL", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>th",
			"<cmd>lua _HTOP_TOGGLE()<CR>",
			{ desc = "Htop", noremap = true, silent = true }
		)

		-- Terminal rapide et exécution
		vim.keymap.set(
			"n",
			"<F5>",
			"<cmd>lua _RUN_CURRENT_FILE()<CR>",
			{ desc = "Exécuter fichier", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<F12>",
			":ToggleTerm direction=float<CR>",
			{ desc = "Terminal flottant", noremap = true, silent = true }
		)
	end,
}
