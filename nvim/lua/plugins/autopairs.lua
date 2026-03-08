return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		check_ts = true, -- Utilise Treesitter pour plus de précision
		disable_filetype = { "TelescopePrompt", "spectre_panel" },
	},
	-- Blink gère maintenant l'autocomplétion le code dessous était valable avec nvim-cmp
	-- config = function()
	--   require("nvim-autopairs").setup({})
	--
	--   -- Intégration avec nvim-cmp (pour que ça fonctionne avec l'autocomplétion)
	--   local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	--   local cmp = require('cmp')
	--   cmp.event:on(
	--     'confirm_done',
	--     cmp_autopairs.on_confirm_done()
	--   )
	-- end
}
