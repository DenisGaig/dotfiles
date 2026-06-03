-- Permet de formater automatiquement sur la sauvegarde avec les bons formatters
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				astro = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				["_"] = { "trim_whitespace" },
			},
			-- La fonction qui décide si on formate à la sauvegarde
			format_on_save = function(bufnr)
				-- On récupère la variable globale pour mini.files (ton HACK de Maria)
				if vim.g.minifiles_active then
					return
				end

				return {
					timeout_ms = 5000,
					lsp_fallback = true,
				}
			end,
			formatters = {
				prettier = {
					-- Force conform à trouver un fichier de config (.prettierrc)
					-- Si pas de config, il ne fera rien (évite de casser des projets tiers)
					require_cwd = true,
				},
			},
		},
	},
}
