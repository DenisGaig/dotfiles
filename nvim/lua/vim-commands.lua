-- Ouvre et crée un buffer scratch (post-it dans Neovim) non enregistré

vim.api.nvim_create_user_command("Scratch", function()
	vim.cmd("bel 10new")
	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = ""
	vim.diagnostic.enable(false, { bufnr = buf })

	-- Désactiver blink.cmp pour ce buffer
	vim.b[buf].completion = false
end, { desc = "Open a scratch buffer", nargs = 0 })
