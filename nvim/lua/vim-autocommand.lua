-- =============================================================================
-- NOTION DE "AUGROUP" (Groupes d'autocommandes)
-- =============================================================================
-- Un "augroup" est un conteneur qui regroupe des autocommandes liées.
--
-- Pourquoi l'utiliser ?
-- 1. Éviter les doublons : Avec { clear = true }, Neovim supprime les anciennes
--    instances de la commande chaque fois que le fichier est rechargé (source).
--    Sans cela, chaque sauvegarde rajouterait une couche inutile, ralentissant l'éditeur.
-- 2. Organisation : Permet de lister (:autocmd) ou supprimer ses commandes
--    propres plus facilement.
-- 3. Stabilité : Empêche des comportements imprévisibles lors du développement
--    de votre configuration.
-- =============================================================================

-- Active uniquement spell pour markdown
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("denis/active_spell", { clear = true }),
	desc = "Active la spellchecking pour Markdown",
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "fr", "en" }
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("denis/active_colorcolumn", { clear = true }),
	desc = "Active la colorcolumn pour Markdown",
	pattern = { "markdown", "text" },
	callback = function()
		vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#313244" })
		vim.opt_local.textwidth = 80 -- saut de ligne auto à 80 caractères
		-- 't' : Auto-wrap pendant la frappe
		-- 'c' : Auto-wrap des commentaires
		-- 'q' : Permet le formatage avec gq/gw
		vim.opt_local.formatoptions = "tcq"

		-- On vide l'expression pour être sûr que gw/gq restent internes
		vim.opt_local.formatexpr = ""
	end,
})

-- Highlight on yank (inutile depuis YankyYanked plugin)
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	desc = "Highlight when yanking (copying) text",
-- 	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
-- 	callback = function()
-- 		vim.hl.on_yank({ higroup = "CurSearch", timeout = 200 })
-- 	end,
-- })

-- Supprime les espaces en fin de ligne
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("denis/trim_whitespace", { clear = true }),
	desc = "Supprime les espaces en fin de ligne au moment de la sauvegarde",
	pattern = "*",
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Retourne à la dernière position du curseur
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("denis/last_location", { clear = true }),
	desc = "Retourne à la dernière position du curseur et centre l'écran",
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("denis/no_auto_comment", { clear = true }),
	desc = "Désactive la continuation automatique des commentaires",
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("denis/close_special_buffers", { clear = true }),
	desc = "Fermeture automatique de Neovim si seul Oil ou Trouble reste ouvert",
	callback = function()
		if #vim.api.nvim_list_wins() == 1 then
			local ft = vim.bo.filetype
			if ft == "trouble" or ft == "oil" or ft == "qf" then
				vim.cmd("quit")
			end
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("denis/close_with_q", { clear = true }),
	desc = "Close with <q>",
	pattern = {
		"git",
		"help",
		"man",
		"qf",
		"scratch",
	},
	callback = function(args)
		if args.match ~= "help" or not vim.bo[args.buf].modifiable then
			vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = args.buf })
		end
	end,
})

-- Affiche les numéros de lignes relatifs seulement quand on est en mode normal
local line_numbers_group = vim.api.nvim_create_augroup("denis/toggle_line_numbers", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	group = line_numbers_group,
	desc = "Toggle relative line numbers on",
	callback = function()
		if vim.wo.nu and not vim.startswith(vim.api.nvim_get_mode().mode, "i") then
			vim.wo.relativenumber = true
		end
	end,
})

-- Retire les numéros de lignes relatifs quand on est en mode insert
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	group = line_numbers_group,
	desc = "Toggle relative line numbers off",
	callback = function(args)
		if vim.wo.nu then
			vim.wo.relativenumber = false
		end

		-- Redraw here to avoid having to first write something for the line numbers to update.
		if args.event == "CmdlineEnter" then
			if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
				vim.cmd.redraw()
			end
		end
	end,
})
