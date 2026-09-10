-- Ajoute des log des variables, des objets et des types rapidement, utile pour le debug
local add = require("vim-pack").add

add {
    {
        src = "chrisgrieser/nvim-chainsaw",
        module_name = "chainsaw",
        opts = {
            marker = "🪚",
        },
        on_setup = function()
            vim.keymap.set("n", "<leader>log", function()
                require("chainsaw").variableLog()
            end, { desc = "Chainsaw: variable log" })

            vim.keymap.set("n", "<leader>loo", function()
                require("chainsaw").objectLog()
            end, { desc = "Chainsaw: object log" })

            vim.keymap.set("n", "<leader>lot", function()
                require("chainsaw").typeLog()
            end, { desc = "Chainsaw: type log" })

            vim.keymap.set("n", "<leader>loc", function()
                require("chainsaw").clearLog()
            end, { desc = "Chainsaw: clear log" })

            vim.keymap.set("n", "<leader>lor", function()
                require("chainsaw").removeLogs()
            end, { desc = "Chainsaw: remove logs" })
        end,
    },
}
