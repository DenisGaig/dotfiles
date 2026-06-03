return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Aller à gauche" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Aller en bas" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Aller en haut" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Aller à droite" },
    { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Précédent" },
  },
}
