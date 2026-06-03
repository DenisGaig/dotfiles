-- lua/plugins/snacks.lua
local add = require('vim-pack').add

add {
    {
        src = 'folke/snacks.nvim',
        opts = {
            -- picker = {
            --     enabled = true,
            --     layouts = {
            --         ivy = {
            --             layout = {
            --                 box = 'vertical',
            --                 backdrop = false,
            --                 row = -1,
            --                 width = 0,
            --                 height = 0.4,
            --                 border = 'top',
            --                 title = ' {title} {live} {flags}',
            --                 title_pos = 'left',
            --                 {
            --                     box = 'horizontal',
            --                     { win = 'list', border = 'rounded' },
            --                     { win = 'preview', title = '{preview}', width = 0.55, border = 'rounded' },
            --                 },
            --                 { win = 'input', height = 1, border = 'bottom' },
            --             },
            --         },
            --     },
            --     layout = { preset = 'ivy' },
            -- },
            image = {
                enabled = true,
                doc = {
                    inline = false,
                    float = true,
                    max_width = 60,
                    max_height = 30,
                },
            },
        },
        on_setup = function()
            -- Keymaps
            vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end,        { desc = 'Search Files' })
            vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end,         { desc = 'Live Grep' })
            vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end,         { desc = 'Search Help' })
            vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end,  { desc = 'Search Diagnostics' })
            vim.keymap.set('n', '<leader>sc', function() Snacks.picker.commands() end,     { desc = 'Search Commands' })
            vim.keymap.set('n', '<leader>sr', function() Snacks.picker.resume() end,       { desc = 'Search Resume' })
            vim.keymap.set('n', '<leader>s.', function() Snacks.picker.recent() end,       { desc = 'Recent Files' })
            vim.keymap.set('n', '<leader>sw', function() Snacks.picker.grep_word() end,    { desc = 'Search Word' })
            vim.keymap.set('n', '<leader><leader>', function() Snacks.picker.buffers() end, { desc = 'Find Buffers' })
            vim.keymap.set('n', '<leader>gr', function() Snacks.picker.lsp_references() end, { desc = 'LSP References' })
            vim.keymap.set('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })
            vim.keymap.set('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end,  { desc = 'LSP Symbols' })
        end,
    },
}
