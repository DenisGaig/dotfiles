return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- Indispensable pour que le plugin sache où chercher les nœuds TSX
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
--
-- return {
-- 	"numToStr/Comment.nvim",
-- 	config = function()
-- 		require("Comment").setup()
-- 	end,
-- }
