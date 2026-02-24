-- CURSOR
vim.opt.cursorline = true

-- NUMBERS
vim.opt.nu = true
vim.opt.relativenumber = true

-- INDENTATION
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- RECHERCHE
vim.opt.ignorecase = true -- recherche insensible à la casse
vim.opt.smartcase = true -- sauf si tu tapes une majuscule
vim.opt.hlsearch = false -- pas de surbrillance persistante après recherche

-- UX
vim.opt.scrolloff = 10 -- garde 10 lignes visibles au dessus/dessous du curseur
vim.opt.wrap = false -- pas de retour à la ligne automatique
vim.opt.signcolumn = "yes" -- colonne gauche toujours visible (évite les sauts LSP)
vim.opt.updatetime = 50 -- réactivité plus rapide
vim.opt.termguicolors = true

-- CLIPBOARD
vim.opt.clipboard = "unnamedplus" -- partage le clipboard système

-- DIAGNOSTIC CONFIG
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },

	-- Can switch between these as you prefer
	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Teest shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = { float = true },
})
