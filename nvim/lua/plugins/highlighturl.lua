-- ~/.config/nvim/lua/plugins/highlight-url.lua
return {
	"itchyny/vim-highlighturl",
	event = "VeryLazy",
	config = function()
		-- Groupe pour éviter de dupliquer les autocmds au rechargement

		vim.api.nvim_create_autocmd("FileType", {
			desc = "Disable URL highlights",
			pattern = {
				"TelescopePrompt",
				"oil",
				"minifiles",
			},
			command = "call highlighturl#disable_local()",
		})
	end,
}
