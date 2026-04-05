return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = { "lua", "astro", "javascript", "python", "vim", "typescript", "markdown", "markdown_inline", "yaml", "mdx" },
			-- sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				-- On désactive la regex classique pour forcer Treesitter
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
		-- -- On dit à Neovim que .mdx = markdown
		-- vim.filetype.add({
		-- 	extension = { mdx = "markdown" },
		-- })

		-- SOLUTION FINALE : On force l'attachement au chargement du buffer
		vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
			pattern = { "mdx", "markdown" },
			callback = function()
				-- On vérifie si Treesitter est déjà lancé, sinon on le force
				local lang = "markdown"
				if not vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
					vim.treesitter.start(0, lang)
				end
			end,
		})
	end,
}
