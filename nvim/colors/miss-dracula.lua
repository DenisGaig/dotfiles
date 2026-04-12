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
	comment = "#B08BBB",
	cyan = "#A7DFEF",
	fuchsia = "#E11299",
	green = "#87E58E",
	grey = "#A9ABAC",
	gutter_fg = "#4B5263",
	lavender = "#6272A4",
	lilac = "#6D5978",
	neon_cyan = "#00DFDF",
	orange = "#FFBFA9",
	pink = "#E48CC1",
	purple = "#BAA0E8",
	red = "#E95678",
	selection = "#3C4148",
	visual = "#3E4452",
	white = "#F6F6F5",
	yellow = "#E8EDA2",
	-- Variantes brillantes/transparentes
	bright_blue = "#D0B5F3",
	bright_cyan = "#BCF4F5",
	bright_green = "#97EDA2",
	bright_red = "#EC6A88",
	transparent_black = "#1E1F29",
	transparent_red = "#2D1B20", -- Un rouge très sombre pour le H1
	transparent_orange = "#2D2420", -- Un orange terreux pour le H2
	transparent_yellow = "#2D2D20", -- Un jaune olive sombre pour le H3
	transparent_purple = "#231B2D", -- Un violet profond:w
}

-- Terminal colors.
vim.g.terminal_color_0 = colors.transparent_black
vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_4 = colors.purple
vim.g.terminal_color_5 = colors.pink
vim.g.terminal_color_6 = colors.cyan
vim.g.terminal_color_7 = colors.white
vim.g.terminal_color_8 = colors.selection
vim.g.terminal_color_9 = colors.bright_red
vim.g.terminal_color_10 = colors.bright_green
vim.g.terminal_color_11 = colors.bright_yellow
vim.g.terminal_color_12 = colors.bright_blue
vim.g.terminal_color_13 = colors.bright_magenta
vim.g.terminal_color_14 = colors.bright_cyan
vim.g.terminal_color_15 = colors.bright_white
vim.g.terminal_color_background = colors.bg
vim.g.terminal_color_foreground = colors.fg

local groups = {
	-- === INTERFACE DE BASE ===
	Boolean = { fg = colors.cyan },
	Character = { fg = colors.green },
	Comment = { fg = colors.comment, italic = true },
	ColorColumn = { bg = colors.selection },
	Conditional = { fg = colors.pink },
	Constant = { fg = colors.yellow },
	CurSearch = { fg = colors.black, bg = colors.fuchsia },
	CursorLine = { bg = colors.selection },
	CursorLineNr = { fg = colors.lilac, bold = true },
	Define = { fg = colors.purple },
	Directory = { fg = colors.cyan },
	EndOfBuffer = { fg = colors.bg }, -- Cache les '~'
	Error = { fg = colors.bright_red },
	ErrorMsg = { fg = colors.bright_red },
	FoldColumn = {},
	Folded = { bg = colors.transparent_black },
	Function = { fg = colors.yellow },
	Identifier = { fg = colors.cyan },
	IncSearch = { link = "CurSearch" },
	Include = { fg = colors.purple },
	Keyword = { fg = colors.cyan },
	Label = { fg = colors.cyan },
	FloatBorder = { fg = colors.purple },
	LineNr = { fg = colors.lilac },
	Macro = { fg = colors.purple },
	MatchParen = { sp = colors.fg, underline = true },
	NonText = { fg = colors.nontext },
	-- Normal = { fg = colors.fg }, -- Pour avoir de la transparence sur le fond
	Normal = { fg = colors.fg, bg = colors.bg }, -- Sans transparence sur le fond
	NormalFloat = { fg = colors.fg, bg = colors.transparent_black }, -- Fond légèremement différent pour les popups
	Number = { fg = colors.orange },
	Pmenu = { bg = colors.transparent_black, fg = colors.fg },
	PmenuSbar = { bg = colors.transparent_blue },
	PmenuSel = { bg = colors.selection, bold = true },
	PmenuThumb = { bg = colors.selection },
	PreCondit = { fg = colors.cyan },
	PreProc = { fg = colors.yellow },
	Question = { fg = colors.purple },
	Repeat = { fg = colors.pink },
	Search = { fg = colors.bg, bg = colors.yellow },
	SignColumn = { bg = colors.bg },
	Special = { fg = colors.green, italic = true },
	SpecialComment = { fg = colors.comment, italic = true },
	SpecialKey = { fg = colors.nontext },
	SpellBad = { sp = colors.bright_red, underline = true },
	SpellCap = { sp = colors.yellow, underline = true },
	SpellLocal = { sp = colors.yellow, underline = true },
	SpellRare = { sp = colors.yellow, underline = true },
	Statement = { fg = colors.purple },
	StorageClass = { fg = colors.pink },
	Structure = { fg = colors.yellow },
	Substitute = { fg = colors.fuchsia, bg = colors.orange, bold = true },
	Title = { fg = colors.cyan },
	Todo = { fg = colors.purple, bold = true, italic = true },
	Type = { fg = colors.cyan },
	TypeDef = { fg = colors.yellow },
	Underlined = { fg = colors.cyan, underline = true },
	VertSplit = { fg = colors.white },
	VirtColumn = { fg = colors.lilac },
	Visual = { bg = colors.visual },
	VisualNOS = { fg = colors.visual },
	WarningMsg = { fg = colors.yellow },
	WildMenu = { fg = colors.transparent_black, bg = colors.white },

	-- === VIM-WINBAR ===
	WinBar = { fg = colors.grey, bg = colors.bg },
	WinBarNC = { bg = colors.transparent_black },
	WinBarDir = { fg = colors.bright_magenta, bg = colors.transparent_black, italic = true },
	WinBarSeparator = { fg = colors.green, bg = colors.transparent_black },

	-- === HTML LEGACY (fallback nvim 0.12) ===
	htmlTag = { fg = colors.pink },
	htmlEndTag = { fg = colors.pink },
	htmlTagName = { fg = colors.pink },
	htmlArg = { fg = colors.green, italic = true },
	htmlSpecialTagName = { fg = colors.cyan },

	-- === CSS fallback groups ===
	cssAtRule = { fg = colors.pink },
	cssAtKeyword = { fg = colors.pink },
	cssDefinition = { fg = colors.cyan },
	cssFontProp = { fg = colors.cyan },
	cssValueNumber = { fg = colors.purple },
	cssUnitDecorator = { fg = colors.pink },
	cssColor = { fg = colors.orange },
	cssIdentifier = { fg = colors.fg },

	-- === ASTRO legacy syntax ===
	astroJavaScript = { fg = colors.pink },
	javaScriptReserved = { fg = colors.pink }, -- const, import, export...
	javaScriptIdentifier = { fg = colors.purple }, -- this, undefined, null...
	javaScriptOperator = { fg = colors.pink }, -- typeof, instanceof...

	-- === TREESITTER (L'ossature Maria) ===
	["@attribute"] = { fg = colors.cyan },
	["@boolean"] = { fg = colors.purple },
	["@character"] = { fg = colors.green },
	["@constant"] = { fg = colors.purple },
	["@constructor"] = { fg = colors.cyan },
	["@error"] = { fg = colors.bright_red },
	["@function"] = { fg = colors.green },
	["@function.builtin"] = { fg = colors.cyan },
	["@function.method"] = { fg = colors.green },
	["@keyword"] = { fg = colors.pink },
	["@keyword.conditional"] = { fg = colors.pink },
	["@keyword.exception"] = { fg = colors.purple },
	["@keyword.function"] = { fg = colors.cyan },
	["@keyword.operator"] = { fg = colors.pink },
	["@keyword.include"] = { fg = colors.pink },
	["@keyword.repeat"] = { fg = colors.pink },
	["@label"] = { fg = colors.cyan },
	["@module"] = { fg = colors.orange },
	["@number"] = { fg = colors.purple },
	["@number.float"] = { fg = colors.green },
	["@operator"] = { fg = colors.pink },
	["@parameter.reference"] = { fg = colors.orange },
	["@property"] = { fg = colors.purple },
	["@punctuation.bracket"] = { fg = colors.cyan },
	["@punctuation.delimiter"] = { fg = colors.cyan },
	["@string"] = { fg = colors.yellow },
	["@string.escape"] = { fg = colors.cyan },
	["@string.regexp"] = { fg = colors.bright_red },
	["@string.special.symbol"] = { fg = colors.purple },
	["@structure"] = { fg = colors.purple },
	["@tag"] = { fg = colors.cyan },
	["@tag.attribute"] = { fg = colors.green },
	["@tag.delimiter"] = { fg = colors.cyan },
	["@type"] = { fg = colors.bright_cyan },
	["@type.builtin"] = { fg = colors.cyan, italic = true },
	["@type.qualifier"] = { fg = colors.pink },
	["@variable"] = { fg = colors.fg },
	["@variable.builtin"] = { fg = colors.purple },
	["@variable.member"] = { fg = colors.orange },
	["@variable.parameter"] = { fg = colors.orange, italic = true },

	-- === SEMANTIC TOKENS (Le Fix pour tes fichiers ouverts) ===
	["@lsp.type.class"] = { fg = colors.bright_cyan },
	["@lsp.type.decorator"] = { fg = colors.green },
	["@lsp.type.enum"] = { fg = colors.cyan },
	["@lsp.type.enumMember"] = { fg = colors.purple },
	["@lsp.type.function"] = { fg = colors.green },
	["@lsp.type.interface"] = { fg = colors.cyan },
	["@lsp.type.method"] = { fg = colors.green },
	["@lsp.type.namespace"] = { fg = colors.orange },
	["@lsp.type.parameter"] = { fg = colors.orange },
	["@lsp.type.property"] = { fg = colors.purple },
	["@lsp.type.struct"] = { fg = colors.cyan },
	["@lsp.type.type"] = { fg = colors.bright_cyan },
	["@lsp.type.variable"] = { fg = colors.fg },
	["@lsp.type.tag"] = { fg = colors.pink },
	["@modifier"] = { fg = colors.cyan },
	["@regexp"] = { fg = colors.yellow },
	["@struct"] = { fg = colors.cyan },
	["@typeParameter"] = { fg = colors.cyan },

	-- === LSP SEMANTIC TOKENS override TSX/TS ===
	["@lsp.type.parameter.typescriptreact"] = { fg = colors.orange, italic = false },
	["@lsp.type.variable.typescriptreact"] = { fg = colors.fg, italic = false },
	["@lsp.type.parameter.typescript"] = { fg = colors.orange, italic = false },

	-- LSP.
	ComplHint = { link = "Comment" },
	DiagnosticDeprecated = { strikethrough = true, fg = colors.fg },
	DiagnosticError = { fg = colors.red },
	DiagnosticFloatingError = { fg = colors.red },
	DiagnosticFloatingHint = { fg = colors.cyan },
	DiagnosticFloatingInfo = { fg = colors.cyan },
	DiagnosticFloatingWarn = { fg = colors.yellow },
	DiagnosticHint = { fg = colors.cyan },
	DiagnosticInfo = { fg = colors.cyan },
	DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
	DiagnosticUnderlineHint = { undercurl = true, sp = colors.cyan },
	DiagnosticUnderlineInfo = { undercurl = true, sp = colors.cyan },
	DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
	DiagnosticUnnecessary = { fg = colors.grey, italic = true },
	DiagnosticVirtualTextError = { fg = colors.red, bg = colors.transparent_red },
	DiagnosticVirtualTextHint = { fg = colors.cyan, bg = colors.transparent_blue },
	DiagnosticVirtualTextInfo = { fg = colors.cyan, bg = colors.transparent_blue },
	DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = colors.transparent_yellow },
	DiagnosticWarn = { fg = colors.yellow },
	LspCodeLens = { fg = colors.cyan, underline = true },
	LspInlayHint = { fg = colors.lavender, italic = true },
	LspReferenceRead = { bg = colors.transparent_blue },
	LspReferenceText = {},
	LspReferenceWrite = { bg = colors.transparent_red },
	LspSignatureActiveParameter = { bold = true, underline = true, sp = colors.fg },

	-- === CSS SPÉCIFIQUE (Fix .astro et .css) ===
	["@property.css"] = { fg = colors.cyan },
	["@type.css"] = { fg = colors.orange },
	["@unit.css"] = { fg = colors.pink },

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
	["@markup.underline"] = { fg = colors.orange },
	["@markup.link.label.markdown"] = { fg = colors.bright_blue },
	["@markup.list.markdown"] = { fg = colors.purple },
	["@markup.raw"] = { fg = colors.yellow },
	["@tag.mdx"] = { fg = colors.bright_magenta },
	["@tag.attribute.mdx"] = { fg = colors.yellow, italic = true },
	["@tag.delimiter.mdx"] = { fg = colors.cyan },

	-- === YAML & FRONTMATTER ===
	["@property.yaml"] = { fg = colors.purple, bold = true },
	["@variable.member.yaml"] = { fg = colors.purple }, -- Pour les clés imbriquées
	["@string.yaml"] = { fg = colors.green },
	["@punctuation.delimiter.yaml"] = { fg = colors.pink },

	-- === Completions:
	BlinkCmpKindClass = { link = "@type" },
	BlinkCmpKindColor = { link = "DevIconCss" },
	BlinkCmpKindConstant = { link = "@constant" },
	BlinkCmpKindConstructor = { link = "@type" },
	BlinkCmpKindEnum = { link = "@variable.member" },
	BlinkCmpKindEnumMember = { link = "@variable.member" },
	BlinkCmpKindEvent = { link = "@constant" },
	BlinkCmpKindField = { link = "@variable.member" },
	BlinkCmpKindFile = { link = "Directory" },
	BlinkCmpKindFolder = { link = "Directory" },
	BlinkCmpKindFunction = { link = "@function" },
	BlinkCmpKindInterface = { link = "@type" },
	BlinkCmpKindKeyword = { link = "@keyword" },
	BlinkCmpKindMethod = { link = "@function.method" },
	BlinkCmpKindModule = { link = "@module" },
	BlinkCmpKindOperator = { link = "@operator" },
	BlinkCmpKindProperty = { link = "@property" },
	BlinkCmpKindReference = { link = "@parameter.reference" },
	BlinkCmpKindSnippet = { link = "@markup" },
	BlinkCmpKindStruct = { link = "@structure" },
	BlinkCmpKindText = { link = "@markup" },
	BlinkCmpKindTypeParameter = { link = "@variable.parameter" },
	BlinkCmpKindUnit = { link = "@variable.member" },
	BlinkCmpKindValue = { link = "@variable.member" },
	BlinkCmpKindVariable = { link = "@variable" },
	BlinkCmpLabelDeprecated = { link = "DiagnosticDeprecated" },
	BlinkCmpLabelDescription = { fg = colors.grey, italic = true },
	BlinkCmpLabelDetail = { fg = colors.grey, bg = colors.bg },
	-- BlinkCmpMenu = { bg = colors.bg },
	BlinkCmpMenuBorder = { bg = colors.bg },
	BlinkCmpMenu = { bg = colors.transparent_black },
	BlinkCmpLabel = { fg = colors.fg },

	-- === KITTY (kitty.conf syntax) ===
	kittyOptionName = { fg = colors.cyan }, -- les noms d'options (font_size, background_opacity...)
	kittyOptionValue = { fg = colors.pink }, -- les valeurs de ces options
	kittyComment = { fg = colors.comment, italic = true },

	-- === PLUGINS ===
	-- Lualine / StatusLine
	StatusLine = { fg = colors.fg, bg = colors.transparent_black },
	StatusLineNC = { fg = colors.grey, bg = colors.bg },

	-- Telescope
	TelescopeBorder = { fg = colors.comment },
	TelescopeSelection = { bg = colors.selection, bold = true },

	-- Nicer sign column highlights for grug-far.
	GrugFarResultsChangeIndicator = { link = "Changed" },
	GrugFarResultsRemoveIndicator = { link = "Removed" },
	GrugFarResultsAddIndicator = { link = "Added" },

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

	-- When triggering flash, use a white font and make everything in the backdrop italic.
	FlashBackdrop = { fg = colors.comment, italic = true }, -- tout le reste du texte
	FlashMatch = { fg = colors.bg, bg = colors.yellow, bold = true }, -- les matches
	FlashLabel = { fg = colors.bg, bg = colors.pink, bold = true }, -- LA lettre à sélectionner
	FlashPrompt = { link = "Normal" },
	FlashCursor = { fg = colors.bg, bg = colors.cyan },

	-- Links.
	HighlightUrl = { underline = true, fg = colors.neon_cyan, sp = colors.neon_cyan },

	-- Nicer yanky highlights.
	YankyPut = { link = "Visual" },
	YankyYanked = { bg = colors.lavender, fg = colors.black },
	-- YankyYanked = { link = "Visual" },
	-- YankyPut = { bg = colors.lavender, fg = colors.black },

	-- === FORCE RENDER-MARKDOWN COLORS ===
	-- RenderMarkdown (Lien vers Treesitter pour éviter les doublons)
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

	-- === PLUGINS ===
}

for group, opts in pairs(groups) do
	vim.api.nvim_set_hl(0, group, opts)
end
