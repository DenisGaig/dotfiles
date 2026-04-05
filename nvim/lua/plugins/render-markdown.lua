return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown", "mdx" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- Requis pour la structure
		"nvim-tree/nvim-web-devicons", -- Optionnel : pour les jolies icônes
	},
	---@module 'render-markdown'
	---@type render_markdown.Config
	opts = {
		file_types = { "markdown", "mdx" },
		yaml = {
			enabled = false,
		},
		html = { enabled = false },
		latex = { enabled = false },

		-- Personnalisation pour ton projet de snippets
		heading = {
			-- Utilise des icônes pour tes titres (utile pour rofi/fzf)
			icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			sign = vim.g.neovim_mode ~= "skitty", -- Pas de marqueur en mode skitty
		},
		bullet = {
			-- enabled = vim.g.neovim_mode ~= "skitty",
			enabled = true,
		},
		code = {
			-- Style des blocs de code (commandes Linux, scripts)
			sign = false,
			width = "block",
			right_pad = 1,
		},
		checkbox = {
			-- Pratique si tu as des listes de tâches techniques
			enabled = true,
			unchecked = {
				-- Replaces '[ ]' of 'task_list_marker_unchecked'
				icon = "   󰄱 ",
				-- Highlight for the unchecked icon
				highlight = "RenderMarkdownUnchecked",
				-- Highlight for item associated with unchecked checkbox
				scope_highlight = nil,
			},
			checked = {
				-- Replaces '[x]' of 'task_list_marker_checked'
				icon = "   󰱒 ",
				-- Highlight for the checked icon
				highlight = "RenderMarkdownChecked",
				-- Highlight for item associated with checked checkbox
				scope_highlight = nil,
			},
		},
		-- Rend les tableaux Markdown beaucoup plus lisibles
		pipe_table = {
			preset = "round",
		},
		-- Important : permet de voir le texte brut sous le curseur pour éditer vite
		anti_conceal = {
			enabled = true,
		},
	},
	-- Keymaps pour toggle Markdown Render
	vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Markdown Render" }),
}
