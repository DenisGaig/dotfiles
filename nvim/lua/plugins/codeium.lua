return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      enable_chat = true,
      config_path = vim.fn.stdpath("config") .. "/codeium_config.json",
      virtual_text = {
        enabled = true,  -- ← IMPORTANT : Activer les suggestions visuelles
        idle_delay = 75,
        map_keys = true,
        key_bindings = {
          accept = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
          clear = "<C-x>",
        },
      }
    })
  end,
}
