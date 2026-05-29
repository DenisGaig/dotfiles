vim.opt.number = true

-- Set my colorscheme.
vim.cmd.colorscheme 'miss-dracula'

-- General setup and goodies (order matters here).
require 'settings'
require 'keymaps'
require 'commands'
require 'autocmds'
require 'winbar'
require 'lsp'
