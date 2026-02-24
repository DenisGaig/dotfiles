-- lua/plugins/init.lua
return {
	-- 1. APPARENCE & THÈME (charger tôt pour éviter les flashes)
	require("plugins.catppuccin"),
	require("plugins.lualine"),
	--  require("plugins.illuminate"),
	--  require("plugins.alpha"),

	-- 2. NAVIGATION & FICHIERS
	--  require("plugins.neo-tree"),
	require("plugins.telescope"),
	require("plugins.oil"),
	--  require("plugins.nvim-tmux-navigator"),

	-- 3. ÉDITION & SYNTAXE (fondamental)
	require("plugins.treesitter"),
	require("plugins.autopairs"),
	require("plugins.multi-cursor"),
	require("plugins.comment"),
	--	require("lua.plugins.disabled.trouble"),

	-- 4. LSP & COMPLÉTION (dans cet ordre)
	require("plugins.lsp-config"),
	require("plugins.none-ls"),
	require("plugins.completions"),

	-- 5. IA & OUTILS EXTERNES
	require("plugins.codeium"),

	-- 6. TERMINAL & GIT
	require("plugins.toggleterm"),
	-- require("plugins.lazygit"),

	-- 7. CONCENTRATION & UX
	require("plugins.colorizer"),
	-- require("todo-comments"),
	-- require("plugins.true-zen"),
}
