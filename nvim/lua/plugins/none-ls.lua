-- None-ls est un gestionnaire de formatters et de linters
return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,

				-- Python (isort d'abord, puis black)
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black,

				null_ls.builtins.diagnostics.ruff,
				-- null_ls.builtins.diagnostics.mypy,

				-- TypeScript/JavaScript/Astro/HTML/CSS/JSON
				null_ls.builtins.formatting.prettier,

				-- Linter JavaScript/TypeScript/Astro
				null_ls.builtins.diagnostics.eslint_d,
			},
			-- Configuration de l'auto-formatage à la sauvegarde
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								filter = function(c)
									return c.name == "null-ls"
								end,
								async = false,
							})
						end,
					})
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
