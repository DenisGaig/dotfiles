local arrows = require("icons").arrows

-- Set <space> as the leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Update times and timeouts.
--vim.o.updatetime = 300
vim.o.timeoutlen = 300
--vim.o.ttimeoutlen = 10

-- Use an indentation of 4 spaces.
vim.o.sw = 4
vim.o.ts = 4
vim.o.et = true

--i Show whitespace.
vim.opt.list = true
vim.opt.listchars = { space = "⋅", trail = "⋅", tab = "  ↦" }

-- NUMBERS
vim.opt.nu = true
vim.opt.relativenumber = true

-- RECHERCHE
vim.opt.ignorecase = true -- recherche insensible à la casse
vim.opt.smartcase = true -- sauf si tu tapes une majuscule
-- vim.opt.hlsearch = false -- pas de surbrillance persistante après recherche

-- UX
vim.opt.scrolloff = 10 -- garde 10 lignes visibles au dessus/dessous du curseur
vim.opt.wrap = true -- pas de retour à la ligne automatique
vim.opt.signcolumn = "yes" -- colonne gauche toujours visible (évite les sauts LSP)
vim.opt.updatetime = 50 -- réactivité plus rapide
vim.opt.termguicolors = true

-- STATUS LINE
vim.opt.cmdheight = 1 -- 0 pour pas de command line avec plugin noice.lua
vim.o.laststatus = 3

-- COMPLETION.
vim.opt.wildignore:append { ".DS_Store" }
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.pumheight = 15
vim.o.pumborder = "rounded"

-- CLIPBOARD
vim.opt.clipboard = "unnamedplus" -- partage le clipboard système

-- Enable mouse mode.
vim.o.mouse = "a"

-- Disable horizontal scrolling.
vim.o.mousescroll = "ver:3,hor:0"

-- FOLD CONFIG pour treesitter (ouvrir et fermer les blocs de code ou markdown)
vim.opt.foldmethod = "expr"
vim.opt.sessionoptions:remove "folds"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- tout ouvert par défaut
vim.opt.foldcolumn = "1" -- Affiche une petite colonne à gauche pour visualiser les folds

-- Folding.(MariaSol version)
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.wo.foldtext = ""

-- UI characters.
vim.opt.fillchars = {
    eob = " ", -- empty lines at the end of a buffer
    fold = " ",
    foldclose = arrows.right,
    foldopen = arrows.down,
    foldsep = " ",
    foldinner = " ",
    msgsep = "─", -- message separator
}

-- Use rounded borders for floating windows.
vim.o.winborder = "rounded"

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
