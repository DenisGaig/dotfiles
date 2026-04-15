return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"lua",
				"astro",
				"css",
				"html",
				"javascript",
				"python",
				"vim",
				"typescript",
				"markdown",
				"markdown_inline",
				"yaml",
				"mdx",
				"tsx",
				"json",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },

			-- Utile pour miniai.lua
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Saute automatiquement au prochain objet
				},
			},
		})

		vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
			pattern = { "mdx", "markdown" },
			callback = function()
				local lang = "markdown"
				if not vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
					vim.treesitter.start(0, lang)
				end
			end,
		})
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
				if lang and not vim.treesitter.highlighter.active[ev.buf] then
					pcall(vim.treesitter.start, ev.buf, lang)
				end
			end,
		})
	end,
}
