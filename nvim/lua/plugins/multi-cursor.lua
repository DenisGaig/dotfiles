return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    -- Désactiver le mapping par défaut de Ctrl+N
    vim.g.VM_maps = {
      ["Find Under"] = '<C-S-d>',  -- Ctrl+Shift+D pour trouver le mot suivant
      ["Find Subword Under"] = '<C-S-d>',
    }
  end,
}
