local add = require("vim-pack").add
local on_plugin_update = require("vim-pack").on_plugin_update

-- Équivalent du `build` de lazy.nvim : recopie les kittens après install/update
on_plugin_update("vim-kitty-navigator", function()
    local plugin = vim.pack.get({ "vim-kitty-navigator" })[1]
    if plugin then
        vim.system({ "sh", "-c", "cp ./*.py ~/.config/kitty/" }, { cwd = plugin.path })
    end
end)

-- À définir AVANT le chargement du plugin
vim.g.kitty_navigator_no_mappings = 1

add {
    {
        src = "knubie/vim-kitty-navigator",
        setup = false,
        on_setup = function()
            local modes = { "n", "v", "i" }
            vim.keymap.set(modes, "<C-h>", "<cmd>KittyNavigateLeft<cr>", { desc = "KittyNavigateLeft" })
            vim.keymap.set(modes, "<C-j>", "<cmd>KittyNavigateDown<cr>", { desc = "KittyNavigateDown" })
            vim.keymap.set(modes, "<C-k>", "<cmd>KittyNavigateUp<cr>", { desc = "KittyNavigateUp" })
            vim.keymap.set(modes, "<C-l>", "<cmd>KittyNavigateRight<cr>", { desc = "KittyNavigateRight" })
        end,
    },
}
