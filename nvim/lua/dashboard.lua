-- ~/.config/nvim/lua/plugins/dashboard.lua

local function center(str)
	local width = vim.api.nvim_get_option("columns")
	local padding = math.floor((width - vim.fn.strdisplaywidth(str)) / 2)
	return string.rep(" ", padding) .. str
end

local function session_exists()
	local ok, autosession = pcall(require, "auto-session")
	if not ok then
		return false
	end
	return autosession.session_exists_for_cwd()
end

local function open_dashboard()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_current_buf(buf)

	local has_session = session_exists()

	local logo = {
		"",
		center([[                                                                       ]]),
		center([[                                                                       ]]),
		center([[                                                                       ]]),
		center([[                                                                       ]]),
		center([[                                                                     ]]),
		center([[       ████ ██████           █████      ██                     ]]),
		center([[      ███████████             █████                             ]]),
		center(
			[[      █████████ ███████████████████ ███   ███████████   ]]
		),
		center([[     █████████  ███    █████████████ █████ ██████████████   ]]),
		center(
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]]
		),
		center(
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]]
		),
		center(
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]]
		),
		center([[                                                                       ]]),
		center([[                                                                       ]]),
		center("[  DG the sylve guardian  ]"),
	}

	local body

	if has_session then
		body = {

			"",
			center("Session : " .. vim.fn.getcwd()),
			"",
			"                   [r]  Restaurer la session",
			"                   [q]  Quitter",
			"",
		}
	else
		body = {
			"",
			center("Neovim"),
			"",
			"                   [f]  Trouver un fichier",
			"                   [r]  Fichiers récents",
			"                   [g]  Grep",
			"                   [e]  Nouveau fichier",
			"                   [q]  Quitter",
			"",
		}
	end

	-- Fusion logo + contenu
	local lines = {}
	vim.list_extend(lines, logo)
	vim.list_extend(lines, body)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].buftype = "nofile"

	local opts = { noremap = true, silent = true, buffer = buf }

	if has_session then
		vim.keymap.set("n", "r", "<cmd>AutoSession restore<cr>", opts)
	else
		vim.keymap.set("n", "f", "<cmd>Telescope find_files<cr>", opts)
		vim.keymap.set("n", "r", "<cmd>Telescope oldfiles<cr>", opts)
		vim.keymap.set("n", "g", "<cmd>Telescope live_grep<cr>", opts)
		vim.keymap.set("n", "e", "<cmd>enew<cr>", opts)
	end

	vim.keymap.set("n", "q", "<cmd>qa<cr>", opts)
end

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			open_dashboard()
		end
	end,
})
