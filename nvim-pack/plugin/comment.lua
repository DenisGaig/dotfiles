-- lua/plugins/comment.lua
local add_on_event = require('vim-pack').add_on_event

add_on_event('BufReadPost', {
    {
        -- Important pour commenter dans les tsx et jsx
        src = 'JoosepAlviste/nvim-ts-context-commentstring',
        module_name = 'ts_context_commentstring',
        opts = { enable_autocmd = false },
    },
    {
        src = 'numToStr/Comment.nvim',
        module_name = 'Comment',
        opts = function()
            return {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
        end,
    },
})
