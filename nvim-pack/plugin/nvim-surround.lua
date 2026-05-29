local add_on_event = require('vim-pack').add_on_event

-- Surround selections, add quotes, etc.
add_on_event('UIEnter', {
    {
        src = 'kylechui/nvim-surround',
    },
})

-- Disable the default keymaps.
vim.g.nvim_surround_no_mappings = true
