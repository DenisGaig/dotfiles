local add = require("vim-pack").add
-- local add_on_event = require("vim-pack").add_on_event

add {
    {
        src = "nickjvandyke/opencode.nvim",
        opts = function()
            return {
                -- Laisse les valeurs par défaut pour commencer.
                -- Tu pourras personnaliser plus tard.
            }
        end,

        on_setup = function()
            local opencode = require "opencode"

            vim.keymap.set({ "n", "x" }, "<leader>oa", function()
                opencode.ask "@this: "
            end, { desc = "OpenCode Ask" })

            vim.keymap.set({ "n", "x" }, "<leader>os", function()
                opencode.select()
            end, { desc = "OpenCode Select" })

            vim.keymap.set({ "n", "x" }, "go", function()
                return opencode.operator "@this "
            end, {
                expr = true,
                desc = "OpenCode Operator",
            })

            vim.keymap.set("n", "goo", function()
                return opencode.operator "@this " .. "_"
            end, {
                expr = true,
                desc = "OpenCode Current Line",
            })

            vim.keymap.set("n", "<S-C-u>", function()
                opencode.command "session.half.page.up"
            end, { desc = "OpenCode Scroll Up" })

            vim.keymap.set("n", "<S-C-d>", function()
                opencode.command "session.half.page.down"
            end, { desc = "OpenCode Scroll Down" })
        end,
    },
}
