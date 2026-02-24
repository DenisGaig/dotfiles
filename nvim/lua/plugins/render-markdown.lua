return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- Requis pour la structure
        'nvim-tree/nvim-web-devicons'      -- Optionnel : pour les jolies icônes
    },
    ---@module 'render-markdown'
    ---@type render_markdown.Config
    opts = {
        -- Personnalisation pour ton projet de snippets
        heading = {
            -- Utilise des icônes pour tes titres (utile pour rofi/fzf)
            icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        },
        code = {
            -- Style des blocs de code (commandes Linux, scripts)
            sign = false,
            width = 'block',
            right_pad = 1,
        },
        checkbox = {
            -- Pratique si tu as des listes de tâches techniques
            enabled = true,
        },
        -- Rend les tableaux Markdown beaucoup plus lisibles
        pipe_table = {
            preset = 'round',
        },
        -- Important : permet de voir le texte brut sous le curseur pour éditer vite
        anti_conceal = {
            enabled = true,
        },
    },
    -- Keymaps pour toggle Markdown Render 
    vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown toggle<cr>', { desc = 'Toggle Markdown Render' })
}
