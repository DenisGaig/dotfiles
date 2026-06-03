local add = require("vim-pack").add

add {
    {
        src = "nvim-tree/nvim-web-devicons",
        opts = {},
    },
    {
        src = "stevearc/oil.nvim",
        opts = {
            columns = { "icon" },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return name == ".." or name == ".git"
                end,
            },
            float = {
                padding = 2,
                max_width = 60,
                max_height = 20,
                border = "rounded",
                override = function(conf)
                    conf.relative = "editor"
                    conf.row = 0
                    conf.col = vim.o.columns - conf.width - 2
                    return conf
                end,
            },
            delete_to_trash = true,
            skip_confirm_for_simple_edits = false,
        },
        on_setup = function()
            vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Oil (flottant)" })
            vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Oil (buffer)" })
        end,
    },
}
