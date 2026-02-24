local map = vim.keymap.set

-- NAVIGATION ENTRE SPLITS
map("n", "<C-h>", "<C-w>h", { desc = "Aller dans la split de gauche" })
map("n", "<C-l>", "<C-w>l", { desc = "Aller dans la split de droite" })
map("n", "<C-j>", "<C-w>j", { desc = "Aller dans la split du bas" })
map("n", "<C-k>", "<C-w>k", { desc = "Aller dans la split du haut" })

-- DÉPLACER DES LIGNES en mode visuel
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Déplacer une ligne vers le bas en mode visuel" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Déplacer une ligne vers le haut en mode visuel" })

-- GARDER LE CURSEUR CENTRÉ
map("n", "<C-d>", "<C-d>zz", { desc = "Descendre d'une demi-page" }) -- descendre demi-page
map("n", "<C-u>", "<C-u>zz", { desc = "Monter d'une demi-page" }) -- monter demi-page
map("n", "n", "nzzv", { desc = "Resultat suivant centré" }) -- résultat de recherche suivant centré
map("n", "N", "Nzzv", { desc = "Resultat precedent centré" }) -- résultat précédent centré

-- SPLITTING & RESIZING
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })

-- BETTER PASTE BEHAVIOR
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- DELETE WITHOUT YANKING
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- CLEAR HIGHLIGHT WHEN PRESSING ESC IN NORMAL MODE
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- OPEN DIAGNOSTIC LIST
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
