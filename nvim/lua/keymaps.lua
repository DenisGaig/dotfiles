local map = vim.keymap.set

-- Remap for dealing with word wrap and adding jumps to the jumplist.to use with <C-o>
map("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
map("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

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
map("n", "<C-d>", "<C-d>zz", { desc = "Descendre d'une demi-page" })
map("n", "<C-u>", "<C-u>zz", { desc = "Monter d'une demi-page" })
map("n", "n", "nzz", { desc = "Resultat suivant centré" })
map("n", "N", "Nzz", { desc = "Resultat precedent centré" })

-- SPLITTING & RESIZING
map("n", "<leader>v", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>h", ":split<CR>", { desc = "Split window horizontally" })
map("n", "<M-,>", "<C-w>5<", { desc = "Resize window to the left" })
map("n", "<M-;>", "<C-w>5>", { desc = "Resize window to the right" })
map("n", "<M-t>", "<C-w>+", { desc = "Resize window to the top" })

-- Make U opposite to u.
map("n", "U", "<C-r>", { desc = "Redo" })

-- Escape and save changes.
map({ "s", "i", "n", "v" }, "<C-s>", "<esc>:w<cr>", { desc = "Exit insert mode and save changes" })
map({ "s", "i", "n", "v" }, "<C-S-s>", function()
    vim.g.skip_formatting = true
    return "<esc>:w<cr>"
end, { desc = "Exit insert mode and save changes (without formatting)", expr = true })

-- QUICK FIX
map("n", "<A-k>", "<cmd>cnext<cr>zz", { desc = "Next quickfix item" })
map("n", "<A-j>", "<cmd>cprev<cr>zz", { desc = "Previous quickfix item" })

-- Quickly go to the end of the line while in insert mode.
map({ "i", "c" }, "<C-l>", "<C-o>A", { desc = "Go to the end of the line" })

-- BETTER PASTE BEHAVIOR
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- DELETE WITHOUT YANKING
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- CLEAR HIGHLIGHT WHEN PRESSING ESC IN NORMAL MODE
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- OPEN LAST OPEN BUFFER
map("n", "<leader>bp", "<C-^>", { desc = "Open last open buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Open next open buffer" })
map("n", "<leader>bb", "<cmd>b#<cr>", { desc = "Alternate buffer" })

-- OPEN DIAGNOSTIC LIST
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TERMINAL
map("t", "<esc>", [[<C-\><C-n>]], { desc = "Mode normal terminal" })
map("n", "<leader>lt", "<cmd>botright split | term<cr>", { desc = "Terminal horizontal bas" })

-- SCRATCH BUFFERS FOR NOTES AND LUA TESTS
map("n", "<leader>ls", "<cmd>:Scratch<cr>", { desc = "Scratch buffer for notes" })
map("n", "<leader>ll", "<cmd>:Scratch lua<cr>", { desc = "Lua Scratch buffer for tests" })

-- Lance un terminal python pour le REPL(Read Eval Print Loop)
map("n", "<leader>tp", function()
    vim.cmd "20split | term python"
end, { desc = "Python REPL" })
