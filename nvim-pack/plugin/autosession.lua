-- lua/plugin/autosession.lua
local add = require('vim-pack').add
add {
    {
        src = 'rmagatti/auto-session',
        opts = {
            suppressed_dirs = { '~/', '/tmp' },
            auto_restore = false,
            auto_save = true,
        },
    },
}
