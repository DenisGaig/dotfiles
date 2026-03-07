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
vim.opt.wrap = true -- pas de retour à la ligne automatique
vim.opt.signcolumn = "yes" -- colonne gauche toujours visible (évite les sauts LSP)
vim.opt.updatetime = 50 -- réactivité plus rapide
vim.opt.termguicolors = true
vim.opt.cmdheight = 1 -- 0 pour pas de command line avec plugin noice.lua

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

-- SPELL : spell checking
-- Désactive globalement mais voir autocommand dans vim-autocommand.lua
vim.opt.spell = false

-- AFFICHE LE CHEMIN DANS LA WINBAR EN HAUT A DROITE
vim.opt.winbar = "%=%{%fnamemodify(expand('%:p:h'), ':~')%}  "
-- Le %= pousse le contenu vers la droite.

-- FOLD CONFIG pour treesitter (ouvrir et fermer les blocs de code ou markdown)
vim.opt.foldmethod = "expr"
vim.opt.sessionoptions:remove("folds")
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- tout ouvert par défaut
vim.opt.foldcolumn = "1" -- Affiche une petite colonne à gauche pour visualiser les folds

-- OPTIONS POUR SKITTY NOTES
if vim.g.neovim_mode == "skitty" then
	vim.opt.number = false
	vim.opt.relativenumber = false
	vim.opt.signcolumn = "no"
	vim.opt.laststatus = 0 -- Cache complètement la statusline
	vim.opt.foldcolumn = "0"
	vim.opt.conceallevel = 2
	-- Affiche le chemin relatif (~/brain/...) ET le nom du fichier
	-- %f : chemin relatif, %m : indicateur de modification [+]
	vim.opt.winbar = "%=%{%fnamemodify(expand('%:p'), ':~')%} %m "
end
