local map = vim.keymap.set
-- NAVIGATION ENTRE SPLITS
map("n", "<C-h>", "<C-w>h", { desc = "Aller dans la split de gauche" })
map("n", "<C-l>", "<C-w>l", { desc = "Aller dans la split de droite" })
map("n", "<C-j>", "<C-w>j", { desc = "Aller dans la split du bas" })
map("n", "<C-k>", "<C-w>k", { desc = "Aller dans la split du haut" })

-- RESTART NEOVIM
map("n", "<leader>R", "<cmd>restart<cr>", { desc = "Restart Neovim" })

-- DÉPLACER DES LIGNES en mode visuel
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Déplacer une ligne vers le bas en mode visuel" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Déplacer une ligne vers le haut en mode visuel" })

-- GARDER LE CURSEUR CENTRÉ
map("n", "<C-d>", "<C-d>zz", { desc = "Descendre d'une demi-page" }) -- descendre demi-page
map("n", "<C-u>", "<C-u>zz", { desc = "Monter d'une demi-page" }) -- monter demi-page
map("n", "n", "nzz", { desc = "Resultat suivant centré" }) -- résultat de recherche suivant centré
map("n", "N", "Nzz", { desc = "Resultat precedent centré" }) -- résultat précédent centré

-- SPLITTING & RESIZING
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>h", ":split<CR>", { desc = "Split window horizontally" })
map("n", "<M-,>", "<C-w>5<", { desc = "Resize window to the left" })
map("n", "<M-;>", "<C-w>5>", { desc = "Resize window to the right" })
map("n", "<M-t>", "<C-w>+", { desc = "Resize window to the top" })
map("n", "<M-b>", "<C-w>-", { desc = "Resize window to the bottom" })

-- Quickly go to the end of the line while in insert mode.
map({ "i", "c" }, "<C-l>", "<C-o>A", { desc = "Go to the end of the line" })

-- BETTER PASTE BEHAVIOR
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- DELETE WITHOUT YANKING
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- CLEAR HIGHLIGHT WHEN PRESSING ESC IN NORMAL MODE
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- OPEN DIAGNOSTIC LIST
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TERMINAL
map("t", "<esc>", [[<C-\><C-n>]], { desc = "Mode normal terminal" })
map("n", "<F12>", "<cmd>botright split | term<cr>", { desc = "Terminal horizontal bas" })
-- Lance un terminal python pour le REPL(Read Eval Print Loop)
map("n", "<leader>tp", function()
	vim.cmd("20split | term python")
end, { desc = "Python REPL" })
