return {
	-- 1. Le gestionnaire (Mason)
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	-- 2. Le lien automatique (Mason-LspConfig)
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			-- Liste des serveurs que tu veux installer automatiquement
			ensure_installed = {
				-- LSP server
				"lua_ls",
				"ts_ls",
				"basedpyright",
				"html",
				"cssls",
				-- Formatters (pour none-ls)
				--"stylua", "black", "isort", "prettier"
			},
			-- automatic_enable est TRUE par défaut, tu peux l'omettre
			-- ou le configurer si besoin:
			-- automatic_enable = true  -- active automatiquement les serveurs installés
			-- automatic_enable = false -- désactive l'activation automatique
			-- automatic_enable = { exclude = { "rust_analyzer" } } -- exclut certains serveurs
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	-- 3. LA CONFIGURATION NEOVIM (LspConfig)
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- vim.lsp.enable("lua_ls") -- vim.les.enable est fait automatiquement maintenant

			-- Si tu as besoin de paramètres spécifiques (ex: pour Lua)
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Pour enlever le warning sur 'vim'
						},
					},
				},
			})
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("basedpyright", {
				capabilities = capabilities,
				settings = {
					basedpyright = {
						analysis = {
							-- On désactive les diagnostics de types car mypy/ruff peuvent le faire
							-- Cela évite d'avoir deux soulignements rouges pour la même erreur
							typeCheckingMode = "standard", -- ou "standard" si vous enlevez mypy

							-- Ces options sont utiles pour la navigation
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			vim.lsp.config("html", {
				capabilities = capabilities,
			})

			vim.lsp.config("cssls", {
				capabilities = capabilities,
			})

			-- OPTIONNEL: Seulement si tu veux personnaliser les keybindings
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }
					local builtin = require("telescope.builtin")

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts, { desc = "Find definitions" })
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts, { desc = "Find code actions" })

					-- Raccourci pour les keybindings de telescope
					vim.keymap.set("n", "grr", builtin.lsp_references, opts, { desc = "Telescope Find references" })
					vim.keymap.set("n", "gri", builtin.lsp_implementations, opts, { desc = "Telescope Find implementations" })
					vim.keymap.set("n", "gO", builtin.lsp_document_symbols, opts, { desc = "Telescope Find document symbols" })
					vim.keymap.set("n", "grt", builtin.lsp_type_definitions, opts, { desc = "Telescope Find type definitions" })
				end,
			})
		end,
	},
}
