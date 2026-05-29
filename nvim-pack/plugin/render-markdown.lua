local pack = require('vim-pack')

-- treesitter et nvim-web-devicons sont déjà installés : pas besoin de les rajouter
pack.add_on_file_type({ 'markdown', 'mdx' }, {
    {
        src = 'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            file_types   = { 'markdown', 'mdx' },
            yaml         = { enabled = false },
            html         = { enabled = false },
            latex        = { enabled = true },
            heading      = {
                icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
                sign  = vim.g.neovim_mode ~= 'skitty',
            },
            bullet       = { enabled = true },
            code         = {
                sign      = false,
                width     = 'block',
                right_pad = 1,
            },
            checkbox     = {
                enabled   = true,
                unchecked = {
                    icon            = '   󰄱 ',
                    highlight       = 'RenderMarkdownUnchecked',
                    scope_highlight = nil,
                },
                checked   = {
                    icon            = '   󰱒 ',
                    highlight       = 'RenderMarkdownChecked',
                    scope_highlight = nil,
                },
            },
            pipe_table   = { preset = 'round' },
            anti_conceal = { enabled = true },
            link         = {
                enabled   = true,
                highlight = 'RenderMarkdownLink',
            },
        },
        on_setup = function()
            vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown toggle<cr>', { desc = 'Toggle Markdown Render' })
        end,
    },
})
