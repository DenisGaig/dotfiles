-- Illumination des mots clés dans les fichiers ouverts
return {
	"RRethy/vim-illuminate",
	event = "VeryLazy",

config = function()
	require("illuminate").configure({
    --delay = 100,
    -- under_cursor = false,
		filetypes_denylist = {
      "snacks_dashboard",
       "snacks_picker_input",
			"mason",
			"harpoon",
			"DressingInput",
			"NeogitCommitMessage",
			"qf",
			"dirvish",
			"oil",
			"minifiles",
			"fugitive",
			"alpha",
			"NvimTree",
			"lazy",
			"NeogitStatus",
			"Trouble",
			"netrw",
			"lir",
			"DiffviewFiles",
			"Outline",
			"Jaq",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"TelescopePrompt",
			"neoree",
		},
	})
  -- Personnalisation des couleurs
  -- Avec juste un léger soulignement, sans fond
  vim.api.nvim_set_hl(0, 'IlluminatedWordText', { underline = true, sp = '#89b4fa' })  -- bleu lavande doux
  vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { underline = true, sp = '#89b4fa' })
  vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { underline = true, sp = '#f9e2af' }) -- jaune doux
end
}




