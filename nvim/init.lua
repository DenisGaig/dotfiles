-- LEADER
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- LAZY INSTALL
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
-- Add lazy to runtime path
vim.opt.rtp:prepend(lazypath)

-- PLUGINS
require("vim-options")
require("vim-keymaps")
require("vim-autocommand")
require("lazy").setup("plugins")
require("rofidex")
require("dashboard")

-- DIAGNOSTICS
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})

-- Icônes de diagnostic
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.defer_fn(function()
-- 			-- Force Neovim à relire les dimensions du terminal
-- 			vim.cmd("mode")
-- 		end, 500)
-- 	end,
-- })
