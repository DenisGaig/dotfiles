local add = require("vim-pack").add

add {
    {
        src = "echasnovski/mini.pick",
        module_name = "mini.pick",
        opts = {
            window = {
                config = function()
                    local width = math.floor(vim.o.columns * 0.5)
                    local height = math.floor(vim.o.lines * 0.35)
                    return {
                        width = width,
                        height = height,
                        col    = math.floor((vim.o.columns - width) ),
                    }
                end,
            },
        },
    },
    {
        src = "echasnovski/mini.extra",
        module_name = "mini.extra",
        opts = {},
        on_setup = function()
            local pick = require "mini.pick"
            local extra = require "mini.extra"

            vim.keymap.set("n", "<leader>ff", function()
                pick.builtin.files()
            end, { desc = "[F]ind Files" })

            vim.keymap.set("n", "<leader>fg", function()
                pick.builtin.grep_live()
            end, { desc = "Live Grep" })

            vim.keymap.set("n", "<leader>fh", function()
                pick.builtin.help()
            end, { desc = "[F]ind Help" })

            vim.keymap.set("n", "<leader>fd", function()
                extra.pickers.diagnostic()
            end, { desc = "[F]ind Diagnostics" })

            vim.keymap.set("n", "<leader>fc", function()
                extra.pickers.commands()
            end, { desc = "[F]ind Commands" })

            vim.keymap.set("n", "<leader>fr", function()
                pick.builtin.resume()
            end, { desc = "[F]ind Resume" })

            vim.keymap.set("n", "<leader>f.", function()
                extra.pickers.oldfiles()
            end, { desc = "Recent Files" })

            vim.keymap.set("n", "<leader>fw", function()
                pick.builtin.grep_live(nil, { source = { name = "Grep Word" } })
            end, { desc = "[F]ind Word" })

            vim.keymap.set("n", "<leader><leader>", function()
                pick.builtin.buffers()
            end, { desc = "[F]ind Buffers" })

            vim.keymap.set("n", "<leader>gr", function()
                extra.pickers.lsp { scope = "references" }
            end, { desc = "LSP References" })

            vim.keymap.set("n", "<leader>sS", function()
                extra.pickers.lsp { scope = "workspace_symbol" }
            end, { desc = "LSP Workspace Symbols" })

            vim.keymap.set("n", "<leader>ss", function()
                extra.pickers.lsp { scope = "document_symbol" }
            end, { desc = "LSP Symbols" })

            vim.keymap.set("n", "<leader>fk", function()
                local global = vim.api.nvim_get_keymap "n" -- en mode normal
                local local_ = vim.api.nvim_buf_get_keymap(0, "n") -- keymap du buffer
                local items = {}
                for _, km in ipairs(vim.list_extend(global, local_)) do
                    local lhs = km.lhs:gsub("^" .. vim.g.mapleader, "<leader>")
                    table.insert(items, {
                        text = string.format("%-15s %s", lhs, km.desc or km.rhs or ""),
                        keymap = km,
                    })
                end
                MiniPick.start {
                    source = {
                        items = items,
                        name = "Keymaps",
                    },
                }
            end, { desc = "[F]ind keymaps" })

            vim.keymap.set("n", "<leader>/", function()
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                local items = {}
                for i, line in ipairs(lines) do
                    table.insert(items, { text = string.format("%4d  %s", i, line), line = i })
                end
                MiniPick.start {
                    source = {
                        items = items,
                        name = "Buffer lines",
                        choose = function(item)
                            local win = vim.fn.win_getid(vim.fn.winnr "#") -- retourne la fenêtre précédente donc le buffer
                            vim.api.nvim_win_set_cursor(win, { item.line, 0 })
                        end,
                    },
                }
            end, { desc = "[/] Fuzzily search in current buffer" })

            local function search_tasks(done)
                local pattern = done and "- [x]" or "- [ ]"
                local title = done and "Tâches complétées" or "Tâches en cours"
                MiniPick.builtin.grep({ pattern = pattern, globs = { "*.md" } }, { source = { name = title } })
            end

            vim.keymap.set("n", "<leader>tt", function()
                search_tasks(false)
            end, { desc = "Lister tâches en cours" })

            vim.keymap.set("n", "<leader>tc", function()
                search_tasks(true)
            end, { desc = "Lister tâches complétées" })
        end,
    },
}
