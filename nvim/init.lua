-- Set my colorscheme.
vim.cmd.colorscheme "miss-dracula"

-- General setup and goodies (order matters here).
require "settings"
require "keymaps"
require "commands"
require "autocmds"
require "statusline"
require "winbar"
require "lsp"
require "config.personal-keymaps"
require "emotions"

vim.treesitter.language.register("markdown", "mdx")
