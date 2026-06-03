local add = require('vim-pack').add

add {
    {
        src = 'lukas-reineke/virt-column.nvim',
        opts = {
            char = '󰮾',
            virtcolumn = '90',
            highlight = 'VirtColumn',
        },
    },
}
