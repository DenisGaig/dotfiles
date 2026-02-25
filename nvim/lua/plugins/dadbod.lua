-- vim-dadbod: plugin de base de donnees SQL
-- Note:
-- utiliser la keymap <leader>S pour afficher la querry après l'avoir sélectionnée
return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			vim.g.db_ui_save_location = "~/.dotfiles/nvim/db_ui"
		end,
	},
}
