local add = require("vim-pack").add

-- Split/join blocks of code.
add {
    {
        src = "nvim-mini/mini.splitjoin",
        opts = {
            mappings = { toggle = "<leader>cj" },
        },
    },
}

-- Uniquement pour le renommage des mappings
vim.keymap.set({ "n", "x" }, "<leader>cj", function()
    require("mini.splitjoin").toggle()
end, { desc = "Toggle split-join" })
