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

-- NEOVIM MODE pour les skitty-notes
vim.g.neovim_mode = vim.env.NEOVIM_MODE or "default"

-- PLUGINS
require("vim-options")
require("vim-keymaps")
require("vim-autocommand")
require("lazy").setup("plugins")
require("rofidex")
require("dashboard")
require("config.keymaps")
require("emotions")

-- FILETYPE DETECTION
vim.filetype.add({
	extension = {
		tcss = "css", -- ou créer un filetype custom "tcss"
		mdx = "mdx",
	},
})

vim.treesitter.language.register("markdown", "mdx")

-- OPTIONS: Line de commande cachée sans action
vim.opt.cmdheight = 0
