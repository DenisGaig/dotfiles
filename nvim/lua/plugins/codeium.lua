return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "hrsh7th/nvim-cmp",
	},
	config = function()
		-- Hack pour empêcher l'erreur "module 'cmp' not found"
		package.preload["cmp"] = function()
			return {
				event = { -- Codeium appelle cmp.event:on(...)
					on = function() end,
				},
				register_source = function() end,
				setup = function() end,
			}
		end

		require("codeium").setup({
			enable_cmp = false,
			enable_chat = true,
			config_path = vim.fn.stdpath("config") .. "/codeium_config.json",
			virtual_text = {
				enabled = true, -- ← IMPORTANT : Activer les suggestions visuelles
				idle_delay = 75,
				-- Changement pour blink: gestion par blink des keybinds
				map_keys = true, -- true avant blink
				key_bindings = {
					accept = "<M-Tab>",
					next = "<M-]>",
					prev = "<M-[>",
					clear = "<C-x>",
				},
			},
		})
	end,
}
