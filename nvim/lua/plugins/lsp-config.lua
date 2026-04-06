-- Setup des LSP (Language Server Protocol) qui permettent de faire de l'auto-completion,
-- de l'auto-formatage, de l'auto-diagnostics, etc.

return {
	-- 1. Le gestionnaire (Mason)
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"markdown-oxide", -- ← nom avec tirets pour Mason
				"astro-language-server",
			},
		},
	},
	-- 2. Le lien automatique (Mason-LspConfig)
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			-- Liste des serveurs que je veux installer automatiquement
			ensure_installed = {
				-- LSP server
				"lua_ls",
				"ts_ls",
				"basedpyright",
				"html",
				"cssls",
				"astro",
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
			-- 0. Configuration de l'auto-completion avec blink
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- 1. Configuration des diagnostics avec les icones
			local icons = require("icons")

			-- On définit les signes pour l'UI globale
			local levels = {
				Error = icons.diagnostics.ERROR,
				Warn = icons.diagnostics.WARN,
				Hint = icons.diagnostics.HINT,
				Info = icons.diagnostics.INFO,
			}

			for type, icon in pairs(levels) do
				local name = "DiagnosticSign" .. type
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end

			-- On configure le moteur de diagnostics
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.diagnostics.ERROR,
						[vim.diagnostic.severity.WARN] = icons.diagnostics.WARN,
						[vim.diagnostic.severity.HINT] = icons.diagnostics.HINT,
						[vim.diagnostic.severity.INFO] = icons.diagnostics.INFO,
					},
				},
				virtual_text = { prefix = "●" },
				update_in_insert = false,
				severity_sort = true,
			})

			-- 2. Configuration des serveurs
			-- Si j'ai besoin de paramètres spécifiques (ex: pour Lua)
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
				settings = {
					css = {
						validate = true,
						lint = {
							-- C'est ici que la magie opère pour Waybar/GTK-CSS
							unknownAtRules = "ignore",
							invalidPropertyValue = "ignore",
						},
					},
				},
			})

			vim.lsp.config("astro", {
				capabilities = capabilities,
			})

			-- markdown-oxide: LSP pour les notes Obsidian/markdown
			vim.lsp.config("markdown_oxide", {
				capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("blink.cmp").get_lsp_capabilities(), {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				}),
			})

			-- OPTIONNEL: Seulement si je veux personnaliser les keybindings
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }
					local builtin = require("telescope.builtin")

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Find definitions" })
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
	-- 4. Le lien Mason <-> None-ls (formatters/linters)
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			ensure_installed = { "stylua", "black", "isort", "ruff", "prettier", "eslint_d" },
			automatic_installation = true,
		},
	},
}
