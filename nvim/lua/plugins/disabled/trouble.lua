return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('trouble').setup()

    vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle win.position=bottom<cr>')
    vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0 win.position=bottom<cr>')
  end
}
