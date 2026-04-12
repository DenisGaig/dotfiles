local trigger_text = ";"

return {
	"saghen/blink.cmp",
	-- On utilise "build" pour compiler localement avec ton cargo
	-- build = "cargo build --release",
	version = "v1.*",

	dependencies = {
		"Exafunction/codeium.nvim",
		"tpope/vim-dadbod",
		"kristijanhusak/vim-dadbod-completion",
		"rafamadriz/friendly-snippets",
		"moyiz/blink-emoji.nvim",
		"Kaiser-Yang/blink-cmp-dictionary",
	},
	opts = {
		-- 1. Désactiver dans Telescope/Oil
		enabled = function()
			return not vim.tbl_contains({ "TelescopePrompt", "oil", "minifiles" }, vim.bo.filetype)
		end,

		sources = {
			default = function()
				-- Base sans snippets hors string ou commentaire
				local sources = { "lsp", "path", "buffer", "codeium", "dadbod", "emoji", "dictionary" }
				local ok, node = pcall(vim.treesitter.get_node)
				if ok and node then
					if
						node:type() ~= "string"
						and not vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
					then
						table.insert(sources, "snippets")
					end
				else
					-- Treesitter indisponible → on inclut quand même les snippets
					table.insert(sources, "snippets")
				end
				return sources
			end,
			providers = {
				lsp = {
					name = "lsp",
					module = "blink.cmp.sources.lsp",
					score_offset = 90,
					min_keyword_length = 0,
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 25,
					min_keyword_length = 2,
					fallbacks = { "snippets", "buffer" }, -- snippets/buffer seulement si pas de résultat path
				},
				snippets = {
					name = "snippets",
					module = "blink.cmp.sources.snippets",
					score_offset = 85,
					min_keyword_length = 1,
					max_items = 15,

					-- Active les snippets en Markdown et autres fichiers de prose après le trigger
					should_show_items = function()
						local prose_filetypes = { "markdown", "mdx", "text", "org", "rst" }
						if vim.tbl_contains(prose_filetypes, vim.bo.filetype) then
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							return before_cursor:match(trigger_text .. "%w*$") ~= nil
						end
						return true
					end,

					-- Supprime le trigger et remplace par le snippet
					transform_items = function(_, items)
						local prose_filetypes = { "markdown", "mdx", "text", "org", "rst" }
						if not vim.tbl_contains(prose_filetypes, vim.bo.filetype) then
							return items
						end
						local line = vim.api.nvim_get_current_line()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = line:sub(1, col)
						local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
						if start_pos then
							for _, item in ipairs(items) do
								if not item.trigger_text_modified then
									item.trigger_text_modified = true
									item.textEdit = {
										newText = item.insertText or item.label,
										range = {
											start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
											["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
										},
									}
								end
							end
						end
						return items
					end,
				},
				buffer = {
					name = "Buffer",
					module = "blink.cmp.sources.buffer",
					score_offset = 15,
					min_keyword_length = 2,
					max_items = 3, -- évite d'être noyé de suggestions buffer
				},
				codeium = {
					name = "Codeium",
					module = "codeium.blink",
					score_offset = 100, -- L'IA en premier
					async = true,
				},
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 30, -- Apparaît après le LSP
					opts = { insert = true },
				},
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					score_offset = 20,
					min_keyword_length = 3, -- démarre seulement à 3 caractères
					max_items = 8,
				},
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
					score_offset = 85,
					min_keyword_length = 2,
				},
			},
		},

		-- 2. Apparence plus moderne (Bords arrondis)
		completion = {
			menu = { border = "rounded" },
			documentation = { window = { border = "rounded" }, auto_show = true },
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
		},

		-- 3. Keymaps (Éviter Enter pour valider en Markdown)
		keymap = {
			preset = "default", -- Tab pour naviguer, Enter pour valider
			-- preset = "none",
			-- Linkarzu désactive Enter car en Markdown, on veut aller à la ligne,
			-- pas forcément accepter une suggestion.
			-- Si tu préfères, utilise : ['<CR>'] = { 'fallback' }
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		},

		-- 4. On garde le moteur de snippets interne de Blink
		snippets = { preset = "luasnip" },
	},
}
