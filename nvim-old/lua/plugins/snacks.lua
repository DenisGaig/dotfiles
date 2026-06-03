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
								{ win = "preview", title = "{preview}", width = 0.55, border = "rounded" },
							},
							{ win = "input", height = 1, border = "bottom" },
						},
					},
				},
				-- Utilise ce layout par défaut
				layout = { preset = "ivy" },
			},
			image = { -- config de Linkarzu
				enabled = true,
				doc = {
					-- Personally I set this to false, I don't want to render all the
					-- images in the file, only when I hover over them
					-- render the image inline in the buffer
					-- if your env doesn't support unicode placeholders, this will be disabled
					-- takes precedence over `opts.float` on supported terminals
					inline = vim.g.neovim_mode == "skitty" and true or false,
					-- only_render_image_at_cursor = vim.g.neovim_mode == "skitty" and false or true,
					-- render the image in a floating window
					-- only used if `opts.inline` is disabled
					float = true,
					-- Sets the size of the image
					-- max_width = 60,
					-- max_width = vim.g.neovim_mode == "skitty" and 20 or 60,
					-- max_height = vim.g.neovim_mode == "skitty" and 10 or 30,
					max_width = vim.g.neovim_mode == "skitty" and 5 or 60,
					max_height = vim.g.neovim_mode == "skitty" and 2.5 or 30,
					-- max_height = 30,
					-- Apparently, all the images that you preview in neovim are converted
					-- to .png and they're cached, original image remains the same, but
					-- the preview you see is a png converted version of that image
					--
					-- Where are the cached images stored?
					-- This path is found in the docs
					-- :lua print(vim.fn.stdpath("cache") .. "/snacks/image")
					-- For me returns `~/.cache/neobean/snacks/image`
					-- Go 1 dir above and check `sudo du -sh ./* | sort -hr | head -n 5`
				},
			},
			-- Tu peux activer d'autres modules snacks plus tard
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
			{
				"<leader>gr",
				function()
					Snacks.picker.lsp_references()
				end,
				desc = "Find LSP references",
			},
		},
	},
}
