return {
	"m4xshen/hardtime.nvim",
	lazy = false,
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = { disabled_keys = {
		["<Up>"] = { "n" },
		["<Down>"] = { "n" },
		["<Left>"] = { "n" },
		["<Right>"] = { "n" },
	} },
}
