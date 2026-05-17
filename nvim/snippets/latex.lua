-- ~/.config/nvim/snippets/latex.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep

-- Raccourci pour autosnippets
-- local as = function(trigger, nodes, opts)
-- 	opts = opts or {}
-- 	opts.snippetType = "autosnippet"
-- 	return s({ trig = trigger, snippetType = "autosnippet", trigEngine = "plain" }, nodes, opts)
-- end
local as = function(trigger, nodes, opts)
	opts = opts or {}
	opts.snippetType = "autosnippet"
	opts.trigEngine = "plain"
	opts.wordTrig = false -- ne capturer que le trigger exact, peu importe ce qui précède
	return s(vim.tbl_extend("force", { trig = trigger }, opts), nodes)
end

local in_math = function()
	local node = vim.treesitter.get_node()
	return node and node:type() == "inline"
end

return {
	-- ===========================================================================
	-- 1. COMPOSANTS MDX CUSTOM
	-- ===========================================================================

	-- Composant <Formula> complet (bloc display avec légende)
	s("formula", {
		t({ "<Formula", '  title="' }),
		i(1, "Titre de la formule"),
		t({ '">', '  <span slot="formula">$$' }),
		i(2, "formule"),
		t({ "$$</span>", '  <span slot="legend">' }),
		i(3, "légende avec $LaTeX$"),
		t({ "</span>", "</Formula>" }),
	}),

	-- Composant <Formula> sans légende
	s("formulan", {
		t({ "<Formula", '  title="' }),
		i(1, "Titre de la formule"),
		t({ '">', '  <span slot="formula">$$' }),
		i(2, "formule"),
		t({ "$$</span>", "</Formula>" }),
	}),

	-- Formule inline simple $...$
	s("formi", {
		t("$"),
		i(1, "formule"),
		t("$"),
	}),

	-- Bloc display autonome $$...$$
	s("formd", {
		t({ "$$", "" }),
		i(1, "formule"),
		t({ "", "$$" }),
	}),

	-- ===========================================================================
	-- 2. ENVIRONNEMENTS MATHÉMATIQUES
	-- ===========================================================================

	-- Système d'équations (cases)
	s("sys", {
		t("\\begin{cases}"),
		t({ "", "  " }),
		i(1, "eq_1"),
		t(" \\\\"),
		t({ "", "  " }),
		i(2, "eq_2"),
		t({ "", "\\end{cases}" }),
	}),

	-- Système à 3 équations
	s("sys3", {
		t("\\begin{cases}"),
		t({ "", "  " }),
		i(1, "eq_1"),
		t(" \\\\"),
		t({ "", "  " }),
		i(2, "eq_2"),
		t(" \\\\"),
		t({ "", "  " }),
		i(3, "eq_3"),
		t({ "", "\\end{cases}" }),
	}),

	-- Alignement (align*)
	s("align", {
		t("\\begin{align*}"),
		t({ "", "  " }),
		i(1, "A"),
		t(" &= "),
		i(2, "B"),
		t(" \\\\"),
		t({ "", "  " }),
		i(3, ""),
		t({ "", "\\end{align*}" }),
	}),

	-- ===========================================================================
	-- 3. FRACTIONS, RACINES, EXPOSANTS, INDICES
	-- ===========================================================================

	s("frac", {
		t("\\frac{"),
		i(1, "num"),
		t("}{"),
		i(2, "den"),
		t("}"),
	}),

	s("dfrac", {
		t("\\dfrac{"),
		i(1, "num"),
		t("}{"),
		i(2, "den"),
		t("}"),
	}),

	s("sqrt", {
		t("\\sqrt{"),
		i(1),
		t("}"),
	}),

	-- Racine n-ième
	s("sqrtn", {
		t("\\sqrt["),
		i(1, "n"),
		t("]{"),
		i(2),
		t("}"),
	}),

	-- Exposant
	s("sq", {
		i(1),
		t("^{"),
		i(2),
		t("}"),
	}),

	-- Indice
	s("sub", {
		i(1),
		t("_{"),
		i(2),
		t("}"),
	}),

	-- Exposant + indice
	s("sqs", {
		i(1),
		t("_{"),
		i(2),
		t("}^{"),
		i(3),
		t("}"),
	}),

	-- Carré
	s("^2", { t("^{2}") }),

	-- Cube
	s("^3", { t("^{3}") }),

	-- Puissance -1
	s("inv", { i(1), t("^{-1}") }),

	-- ===========================================================================
	-- 4. SOMMES, PRODUITS, INTÉGRALES, LIMITES
	-- ===========================================================================

	s("sum", {
		t("\\sum_{"),
		i(1, "i=0"),
		t("}^{"),
		i(2, "n"),
		t("} "),
		i(3),
	}),

	s("prod", {
		t("\\prod_{"),
		i(1, "i=0"),
		t("}^{"),
		i(2, "n"),
		t("} "),
		i(3),
	}),

	s("int", {
		t("\\int_{"),
		i(1, "a"),
		t("}^{"),
		i(2, "b"),
		t("} "),
		i(3, "f(x)"),
		t("\\, d"),
		i(4, "x"),
	}),

	-- Intégrale double
	s("iint", {
		t("\\iint_{"),
		i(1, "D"),
		t("} "),
		i(2, "f(x,y)"),
		t("\\, d"),
		i(3, "x"),
		t("\\, d"),
		i(4, "y"),
	}),

	-- Intégrale de contour
	s("oint", {
		t("\\oint_{"),
		i(1, "C"),
		t("} "),
		i(2, "f"),
		t("\\, d"),
		i(3, "l"),
	}),

	s("lim", {
		t("\\lim_{"),
		i(1, "x"),
		t(" \\to "),
		i(2, "\\infty"),
		t("} "),
		i(3),
	}),

	s("limp", {
		t("\\lim_{"),
		i(1, "x"),
		t(" \\to "),
		i(2, "0^+"),
		t("} "),
		i(3),
	}),

	-- ===========================================================================
	-- 5. VECTEURS, MATRICES, NORMES
	-- ===========================================================================

	s("vec", {
		t("\\vec{"),
		i(1),
		t("}"),
	}),

	-- Vecteur avec flèche longue (overrightarrow)
	s("vecl", {
		t("\\overrightarrow{"),
		i(1, "AB"),
		t("}"),
	}),

	-- Norme
	s("norm", {
		t("\\left\\| "),
		i(1),
		t(" \\right\\|"),
	}),

	-- Valeur absolue
	s("abs", {
		t("\\left| "),
		i(1),
		t(" \\right|"),
	}),

	-- Matrice 2×2
	s("mat2", {
		t("\\begin{pmatrix}"),
		t({ "", "  " }),
		i(1, "a"),
		t(" & "),
		i(2, "b"),
		t(" \\\\"),
		t({ "", "  " }),
		i(3, "c"),
		t(" & "),
		i(4, "d"),
		t({ "", "\\end{pmatrix}" }),
	}),

	-- Matrice 3×3
	s("mat3", {
		t("\\begin{pmatrix}"),
		t({ "", "  " }),
		i(1, "a"),
		t(" & "),
		i(2, "b"),
		t(" & "),
		i(3, "c"),
		t(" \\\\"),
		t({ "", "  " }),
		i(4, "d"),
		t(" & "),
		i(5, "e"),
		t(" & "),
		i(6, "f"),
		t(" \\\\"),
		t({ "", "  " }),
		i(7, "g"),
		t(" & "),
		i(8, "h"),
		t(" & "),
		i(9, "i"),
		t({ "", "\\end{pmatrix}" }),
	}),

	-- Déterminant 2×2
	s("det2", {
		t("\\begin{vmatrix}"),
		t({ "", "  " }),
		i(1, "a"),
		t(" & "),
		i(2, "b"),
		t(" \\\\"),
		t({ "", "  " }),
		i(3, "c"),
		t(" & "),
		i(4, "d"),
		t({ "", "\\end{vmatrix}" }),
	}),

	-- Produit scalaire
	s("dot", {
		t("\\vec{"),
		i(1, "u"),
		t("} \\cdot \\vec{"),
		i(2, "v"),
		t("}"),
	}),

	-- Produit vectoriel
	s("cross", {
		t("\\vec{"),
		i(1, "u"),
		t("} \\times \\vec{"),
		i(2, "v"),
		t("}"),
	}),

	-- ===========================================================================
	-- 6. LETTRES GRECQUES (autosnippets — se déclenchent sans Tab)
	-- Préfixe @ pour éviter les collisions avec du texte normal
	-- ===========================================================================

	as("@a", { t("\\alpha") }),
	as("@b", { t("\\beta") }),
	as("@g", { t("\\gamma") }),
	as("@G", { t("\\Gamma") }),
	as("@d", { t("\\delta") }),
	as("@D", { t("\\Delta") }),
	as("@e", { t("\\epsilon") }),
	as("@ve", { t("\\varepsilon") }),
	as("@z", { t("\\zeta") }),
	as("@h", { t("\\eta") }),
	as("@t", { t("\\theta") }),
	as("@T", { t("\\Theta") }),
	as("@vt", { t("\\vartheta") }),
	as("@k", { t("\\kappa") }),
	as("@l", { t("\\lambda") }),
	as("@L", { t("\\Lambda") }),
	as("@m", { t("\\mu") }),
	as("@n", { t("\\nu") }),
	as("@x", { t("\\xi") }),
	as("@X", { t("\\Xi") }),
	as("@p", { t("\\pi") }),
	as("@P", { t("\\Pi") }),
	as("@r", { t("\\rho") }),
	as("@s", { t("\\sigma") }),
	as("@S", { t("\\Sigma") }),
	as("@ta", { t("\\tau") }),
	as("@u", { t("\\upsilon") }),
	as("@f", { t("\\phi") }),
	as("@vf", { t("\\varphi") }),
	as("@F", { t("\\Phi") }),
	as("@c", { t("\\chi") }),
	as("@ps", { t("\\psi") }),
	as("@Ps", { t("\\Psi") }),
	as("@w", { t("\\omega") }),
	as("@W", { t("\\Omega") }),

	-- ===========================================================================
	-- 7. SYMBOLES ET RELATIONS
	-- ===========================================================================

	s("inf", { t("\\infty") }),
	s("neq", { t("\\neq") }),
	s("leq", { t("\\leq") }),
	s("geq", { t("\\geq") }),
	s("approx", { t("\\approx") }),
	s("equiv", { t("\\equiv") }),
	s("propto", { t("\\propto") }),
	s("pm", { t("\\pm") }),
	s("mp", { t("\\mp") }),
	s("cdot", { t("\\cdot") }),
	s("times", { t("\\times") }),
	s("div", { t("\\div") }),
	s("forall", { t("\\forall") }),
	s("exists", { t("\\exists") }),
	s("in", { t("\\in") }),
	s("notin", { t("\\notin") }),
	s("subset", { t("\\subset") }),
	s("cup", { t("\\cup") }),
	s("cap", { t("\\cap") }),
	s("empty", { t("\\emptyset") }),
	s("to", { t("\\to") }),
	s("iff", { t("\\iff") }),
	s("impl", { t("\\implies") }),
	s("and", { t("\\land") }),
	s("or", { t("\\lor") }),
	s("not", { t("\\lnot") }),

	-- Ensembles classiques
	s("NN", { t("\\mathbb{N}") }),
	s("ZZ", { t("\\mathbb{Z}") }),
	s("QQ", { t("\\mathbb{Q}") }),
	s("RR", { t("\\mathbb{R}") }),
	s("CC", { t("\\mathbb{C}") }),

	-- Parenthèses auto-adaptatives
	s("lr(", {
		t("\\left( "),
		i(1),
		t(" \\right)"),
	}),
	s("lr[", {
		t("\\left[ "),
		i(1),
		t(" \\right]"),
	}),
	s("lr{", {
		t("\\left\\{ "),
		i(1),
		t(" \\right\\}"),
	}),

	-- ===========================================================================
	-- 8. PHYSIQUE / SCIENCES
	-- ===========================================================================

	-- Unités (style texte droit dans les formules)
	s("unit", {
		t("\\,\\text{"),
		i(1, "m"),
		t("}"),
	}),

	-- Unités courantes en autosnippet
	as("_m", { t("\\,\\text{m}") }),
	as("_km", { t("\\,\\text{km}") }),
	as("_s", { t("\\,\\text{s}") }),
	as("_ms", { t("\\,\\text{ms}") }),
	as("_kg", { t("\\,\\text{kg}") }),
	as("_g", { t("\\,\\text{g}") }),
	as("_N", { t("\\,\\text{N}") }),
	as("_J", { t("\\,\\text{J}") }),
	as("_W", { t("\\,\\text{W}") }),
	as("_kW", { t("\\,\\text{kW}") }),
	as("_V", { t("\\,\\text{V}") }),
	as("_A", { t("\\,\\text{A}") }),
	as("_ohm", { t("\\,\\Omega") }),
	as("_Hz", { t("\\,\\text{Hz}") }),
	as("_kHz", { t("\\,\\text{kHz}") }),
	as("_deg", { t("^{\\circ}") }),

	-- Notation dérivée
	s("ddt", {
		t("\\frac{d"),
		i(1, "x"),
		t("}{dt}"),
	}),

	s("dndtn", {
		t("\\frac{d^{"),
		i(1, "n"),
		t("}"),
		i(2, "x"),
		t("}{dt^{"),
		rep(1),
		t("}}"),
	}),

	-- Dérivée partielle
	s("pdd", {
		t("\\frac{\\partial "),
		i(1, "f"),
		t("}{\\partial "),
		i(2, "x"),
		t("}"),
	}),

	-- Gradient, divergence, rotationnel
	s("grad", { t("\\vec{\\nabla} "), i(1) }),
	s("divv", { t("\\vec{\\nabla} \\cdot "), i(1) }),
	s("rotat", { t("\\vec{\\nabla} \\times "), i(1) }),
	s("lapl", { t("\\nabla^2 "), i(1) }),

	-- Formules physiques fréquentes
	s("pfd", { -- F = ma
		t("\\vec{F} = m \\cdot \\vec{a}"),
	}),
	s("pfe", { -- E = mc²
		t("E = m c^{2}"),
	}),
	s("pfv", { -- v = d/t
		t("v = \\frac{d}{t}"),
	}),
	s("pfohm", { -- U = RI
		t("U = R \\cdot I"),
	}),
	s("pfp", { -- P = UI
		t("P = U \\cdot I"),
	}),
	s("pfj", { -- P = RI²
		t("P = R \\cdot I^{2}"),
	}),

	-- ===========================================================================
	-- 9. AUTOSNIPPETS DE CONFORT
	-- Inspirés de la méthode Gilles Castel
	-- ===========================================================================

	-- mk → math inline $...$
	as("mk", {
		t("$"),
		i(1),
		t("$"),
	}),

	-- dm → display math $$...$$
	as("dm", {
		t({ "$$", "" }),
		i(1),
		t({ "", "$$" }),
	}),

	-- // → fraction (en mode math)
	as("//", {
		t("\\frac{"),
		i(1),
		t("}{"),
		i(2),
		t("}"),
	}, { condition = in_math }),

	-- == → alignement &=
	as("==", {
		t("&= "),
		i(1),
	}, { condition = in_math }),

	-- ... → \ldots
	as("...", { t("\\ldots") }, { condition = in_math }),

	-- ** → \cdot (multiplication centrée)
	as("**", { t("\\cdot") }, { condition = in_math }),

	-- -> → \to
	as("->", { t("\\to") }, { condition = in_math }),

	-- => → \implies
	as("=>", { t("\\implies") }, { condition = in_math }),

	-- <=> → \iff
	as("<=>", { t("\\iff") }, { condition = in_math }),

	-- ~~ → \approx
	as("~~", { t("\\approx") }, { condition = in_math }),

	-- != → \neq
	as("!=", { t("\\neq") }, { condition = in_math }),

	-- oo → \infty
	as("oo", { t("\\infty") }, { condition = in_math }),

	-- ooo → \emptyset
	as("ooo", { t("\\emptyset") }, { condition = in_math }),
}
