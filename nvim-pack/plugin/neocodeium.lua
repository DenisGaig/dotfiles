local add_on_event = require('vim-pack').add_on_event

add_on_event('InsertEnter', {
    {
        src = 'monkoose/neocodeium',
        opts = {
            show_label = false,
        },
        on_setup = function()
            vim.keymap.set('i', '<M-Tab>', function()
                require('neocodeium').accept()
            end, { desc = 'Accept AI suggestion' })
            vim.keymap.set('i', '<M-w>', function()
                require('neocodeium').accept_word()
            end, { desc = 'Accept AI suggestion word' })
            vim.keymap.set('i', '<M-l>', function()
                require('neocodeium').accept_line()
            end, { desc = 'Accept AI suggestion line' })
        end,
    },
})
