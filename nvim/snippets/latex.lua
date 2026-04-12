-- ~/.config/nvim/snippets/latex.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
	-- Raccourci pour une fraction
	s("frac", {
		t("\\frac{"),
		i(1),
		t("}{"),
		i(2),
		t("}"),
	}),

	-- Raccourci pour un vecteur (très utile en physique !)
	s("vec", {
		t("\\vec{"),
		i(1),
		t("}"),
	}),

	-- Raccourci pour une racine carrée
	s("sqrt", {
		t("\\sqrt{"),
		i(1),
		t("}"),
	}),

	-- Lettres grecques rapides
	s("ga", { t("\\alpha") }),
	s("gb", { t("\\beta") }),
	s("gd", { t("\\delta") }),
	s("gD", { t("\\Delta") }),
	s("go", { t("\\omega") }),
	s("gO", { t("\\Omega") }),
	s("gp", { t("\\varphi") }), -- phi "joli"
	s("gr", { t("\\rho") }),

	-- Snippet générique pour n'importe quelle unité
	s("un", {
		t("\\text{ "),
		i(1, "unité"),
		t(" }"),
	}),

	-- Unités ultra-rapides pour tes cours
	s("uV", { t("\\text{ V}") }),
	s("uA", { t("\\text{ A}") }),
	s("uT", { t("\\text{ T}") }),
	s("uW", { t("\\text{ W}") }), -- Watts
	s("uO", { t("\\Omega") }), -- Ohms (le symbole grec est mieux)
}
