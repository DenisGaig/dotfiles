return {
	"saghen/blink.cmp",
	-- On utilise "build" pour compiler localement avec ton cargo
	-- build = "cargo build --release",
	-- Pas besoin de version spécifique si on compile depuis la source
	-- mais on peut laisser la version stable par sécurité
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
			default = { "lsp", "path", "snippets", "buffer", "codeium", "dadbod", "emoji", "dictionary" },
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
					min_keyword_length = 2,
					max_items = 15,
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
					auto_insert = true,
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
