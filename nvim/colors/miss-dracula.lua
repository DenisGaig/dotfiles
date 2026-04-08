-- miss-dracula.lua
vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") then
	vim.cmd.syntax("reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "miss-dracula"

local colors = {
	bg = "#151B20",
	fg = "#D1D1D1",
	black = "#000000",
	white = "#F6F6F5",
	grey = "#A9ABAC",
	comment = "#B08BBB",
	purple = "#BAA0E8",
	pink = "#E48CC1",
	fuchsia = "#E11299",
	green = "#87E58E",
	cyan = "#A7DFEF",
	yellow = "#E8EDA2",
	orange = "#FFBFA9",
	red = "#E95678",
	-- Variantes brillantes/transparentes
	bright_blue = "#D0B5F3",
	bright_cyan = "#BCF4F5",
	bright_green = "#97EDA2",
	bright_red = "#EC6A88",
	selection = "#3C4148",
	transparent_black = "#1E1F29",
	transparent_red = "#2D1B20", -- Un rouge très sombre pour le H1
	transparent_orange = "#2D2420", -- Un orange terreux pour le H2
	transparent_yellow = "#2D2D20", -- Un jaune olive sombre pour le H3
	transparent_purple = "#231B2D", -- Un violet profond:w
	visual = "#3E4452",
}

local groups = {
	-- === INTERFACE DE BASE ===
	Normal = { fg = colors.fg, bg = colors.bg },
	NormalFloat = { fg = colors.fg, bg = colors.transparent_black }, -- Fond légèremement différent pour les popups
	FloatBorder = { fg = colors.purple },
	Comment = { fg = colors.comment, italic = true },
	LineNr = { fg = colors.purple },
	CursorLine = { bg = colors.selection },
	CursorLineNr = { fg = colors.pink, bold = true },
	Visual = { bg = colors.visual },
	EndOfBuffer = { fg = colors.bg }, -- Cache les '~'
	Pmenu = { bg = colors.transparent_black, fg = colors.fg },
	PmenuSel = { bg = colors.selection, bold = true },

	-- === TREE-SITTER (Générique) ===
	["@variable"] = { fg = colors.fg },
	["@function"] = { fg = colors.yellow },
	["@keyword"] = { fg = colors.pink },
	["@string"] = { fg = colors.green },
	["@punctuation.bracket"] = { fg = colors.cyan },

	-- === MARKDOWN & MDX ===
	-- === TITRES GÉNÉRIQUES TREESITTER (Priorité Haute) ===
	["@markup.heading.1"] = { fg = colors.red, bold = true },
	["@markup.heading.2"] = { fg = colors.orange, bold = true },
	["@markup.heading.3"] = { fg = colors.yellow, bold = true },
	["@markup.heading.4"] = { fg = colors.green, bold = true },
	["@markup.heading.5"] = { fg = colors.cyan, bold = true },
	["@markup.heading.6"] = { fg = colors.purple, bold = true },

	--- === LIENS SPÉCIFIQUES (Sécurité) ====
	["@markup.heading.1.markdown"] = { link = "@markup.heading.1" },
	["@markup.heading.2.markdown"] = { link = "@markup.heading.2" },
	["@markup.heading.3.markdown"] = { link = "@markup.heading.3" },

	["@markup.strong"] = { fg = colors.orange, bold = true },
	["@markup.italic"] = { fg = colors.yellow, italic = true },
	["@markup.link.label.markdown"] = { fg = colors.bright_blue },
	["@markup.list.markdown"] = { fg = colors.purple },
	["@tag.mdx"] = { fg = colors.bright_magenta },
	["@tag.attribute.mdx"] = { fg = colors.yellow, italic = true },
	["@tag.delimiter.mdx"] = { fg = colors.cyan },

	-- === YAML & FRONTMATTER ===
	["@property.yaml"] = { fg = colors.purple, bold = true },
	["@variable.member.yaml"] = { fg = colors.purple }, -- Pour les clés imbriquées
	["@string.yaml"] = { fg = colors.green },
	["@punctuation.delimiter.yaml"] = { fg = colors.pink },

	-- === PLUGINS ===
	-- Lualine / StatusLine
	StatusLine = { fg = colors.fg, bg = colors.transparent_black },
	StatusLineNC = { fg = colors.grey, bg = colors.bg },

	-- Telescope
	TelescopeBorder = { fg = colors.comment },
	TelescopeSelection = { bg = colors.selection, bold = true },

	-- GitSigns
	GitSignsAdd = { fg = colors.green },
	GitSignsChange = { fg = colors.bright_blue },
	GitSignsDelete = { fg = colors.red },

	-- Todo-Comments
	TodoBgTODO = { fg = colors.black, bg = colors.yellow, bold = true },
	TodoBgFIX = { fg = colors.black, bg = colors.red, bold = true },
	TodoFgNOTE = { fg = colors.bright_cyan },

	-- IBL (Indent)
	IblIndent = { fg = colors.selection },
	IblScope = { fg = colors.purple },

	-- RenderMarkdown (Lien vers Treesitter pour éviter les doublons)
	-- === FORCE RENDER-MARKDOWN COLORS ===
	-- Niveau 1 : Rouge
	RenderMarkdownH1 = { fg = colors.red, bold = true },
	RenderMarkdownH1Bg = { fg = colors.red, bg = colors.transparent_red, bold = true },
	RenderMarkdownH1Icon = { fg = colors.red },

	-- Niveau 2 : Orange
	RenderMarkdownH2 = { fg = colors.orange, bold = true },
	RenderMarkdownH2Bg = { fg = colors.orange, bg = colors.transparent_orange, bold = true },
	RenderMarkdownH2Icon = { fg = colors.orange },

	-- Niveau 3 : Jaune
	RenderMarkdownH3 = { fg = colors.yellow, bold = true },
	RenderMarkdownH3Bg = { fg = colors.yellow, bg = colors.transparent_yellow, bold = true },
	RenderMarkdownH3Icon = { fg = colors.yellow },

	-- Niveau 4 : Vert (pour la suite)
	RenderMarkdownH4 = { fg = colors.green, bold = true },
	RenderMarkdownH4Bg = { fg = colors.green, bg = colors.transparent_green, bold = true },
	RenderMarkdownH4Icon = { fg = colors.green },

	-- Blocs de code (très important pour tes snippets)
	RenderMarkdownCode = { bg = colors.transparent_black },
	RenderMarkdownCodeInline = { bg = colors.selection, fg = colors.bright_cyan },

	-- Listes et Checkboxes
	RenderMarkdownBullet = { fg = colors.orange },
	RenderMarkdownUnchecked = { fg = colors.red },
	RenderMarkdownChecked = { fg = colors.green },

	-- Tableaux (pour ton preset "round")
	RenderMarkdownTableHead = { fg = colors.purple, bold = true },
	RenderMarkdownTableFill = { fg = colors.purple },
	-- MiniFiles / Oil
	MiniFilesBorder = { fg = colors.comment },
	MiniFilesTitle = { fg = colors.pink, bold = true },
	OilDir = { fg = colors.cyan, bold = true },
}

for group, opts in pairs(groups) do
	vim.api.nvim_set_hl(0, group, opts)
end
