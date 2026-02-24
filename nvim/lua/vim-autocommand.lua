vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank({ higroup = "CurSearch", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Supprime les espaces en fin de ligne au moment de la sauvegarde",
	pattern = "*",
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Retourne à la dernière position du curseur lors de l'ouverture d'un fichier",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Désactive la continuation automatique des commentaires",
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Fermeture automatique de Neovim si seul Oil ou Trouble reste ouvert",
	group = vim.api.nvim_create_augroup("CloseSpecialBuffers", { clear = true }),
	callback = function()
		if #vim.api.nvim_list_wins() == 1 then
			local ft = vim.bo.filetype
			if ft == "trouble" or ft == "oil" or ft == "qf" then
				vim.cmd("quit")
			end
		end
	end,
})
