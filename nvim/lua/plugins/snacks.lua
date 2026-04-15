---@diagnostic disable: undefined-global
return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			picker = {
				enabled = true,
				layouts = {
					ivy = {
						layout = {
							box = "vertical",
							backdrop = false,
							row = -1,
							width = 0,
							height = 0.4,
							border = "top",
							title = " {title} {live} {flags}",
							title_pos = "left",
							{
								box = "horizontal",
								{ win = "list", border = "rounded" },
								{ win = "preview", title = "{preview}", width = 0.6, border = "rounded" },
							},
							{ win = "input", height = 1, border = "bottom" },
						},
					},
				},
				-- Utilise ce layout par défaut
				layout = { preset = "ivy" },
			}, -- Tu peux activer d'autres modules snacks plus tard
			-- bigfile = { enabled = true },
			-- notifier = { enabled = true },
		},
		keys = {
			-- 🔑 LSP Symbols dans le buffer courant (comme Linkarzu)
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "[S]nacks LSP Workspace [S]ymbols",
			},
			-- 🔑 Titres markdown (#, ##, ###) du buffer courant
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols({
						filter = {
							kind = "String", -- fallback si pas de LSP markdown
						},
					})
				end,
				desc = "[S]nacks [s]ections markdown",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.commands()
				end,
				desc = "Search Commands",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Search Diagnostics",
			},
			{
				"<leader>sf",
				function()
					Snacks.picker.files()
				end,
				desc = "Search Files",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "Search Help Tags",
			},
			-- {
			-- 	"<leader>sk",
			-- 	function()
			-- 		Snacks.picker.keymaps()
			-- 	end,
			-- 	desc = "Search Keymaps",
			-- },
			{
				"<leader>sr",
				function()
					Snacks.picker.resume()
				end,
				desc = "Search Resume",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Search current Word",
				mode = { "n", "v" },
			},
			{
				"<leader>s.",
				function()
					Snacks.picker.recent()
				end,
				desc = "Search Recent Files",
			},
			{
				"<leader><leader>",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Find existing buffers",
			},
		},
	},
}
