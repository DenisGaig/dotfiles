return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- On définit si on doit cacher la barre
		local hide_lualine = vim.g.neovim_mode == "skitty"

		require("lualine").setup({
			options = {
				theme = "dracula",
				-- Si hide_lualine est vrai, on désactive Lualine
				disabled_filetypes = hide_lualine and { "statusline", "markdown" } or {},
				-- On garde globalstatus actif pour les autres modes si tu aimes ça
				globalstatus = true,
			},
		})

		-- Forcer la disparition si on est en mode skitty
		if hide_lualine then
			vim.opt.laststatus = 0
		end
	end,
}
