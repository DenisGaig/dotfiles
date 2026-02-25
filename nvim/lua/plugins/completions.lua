return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"onsails/lspkind.nvim", -- nouveau
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			-- Set up nvim-cmp.
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			require("luasnip.loaders.from_vscode").lazy_load()

			lspkind.init({
				mode = "symbol_text",
			})

			local kind_formatter = lspkind.cmp_format({
				mode = "symbol_text",
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[LSP]",
					luasnip = "[snip]",
					codeium = "[codeium]",
					lazydev = "[lazydev]",
					path = "[path]",
				},
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
					},
					documentation = {
						border = "rounded",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{
						name = "lazydev", -- nouveau mais non installé voir https://github.com/folke/lazydev.nvim
						group_index = 0, -- priorité sur LuaLS, évite les doublons
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "codeium" },
				}, {
					{ name = "buffer" },
				}),

				-- Formatage avec lspkind
				formatting = {
					fields = { "abbr", "icon", "kind", "menu" },
					expandable_indicator = true,
					format = function(entry, vim_item)
						-- Lspkind setup for icons
						vim_item = kind_formatter(entry, vim_item)

						return vim_item
					end,
				},

				-- Tri des suggestions
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})

			-- Config spécifique SQL pour vim-dadbod
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})
		end,
	},
}
