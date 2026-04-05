-- ~/.config/nvim/snippets/markdown.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Fonction pour générer la date actuelle (format: 2026-03-26)
local function current_date()
	return os.date("%Y-%m-%d")
end

return {
	s("daily", {
		-- Emotions et besoins
		t("- 😢 Emotions: "),
		t({ "", "" }),
		t("- 💙 Besoins: "),
		t({ "", "", "" }),

		-- Apprentissages
		t("### 🧠 Apprentissages"),
		t({ "", "", "" }),
		i(1, "Ce que j'ai découvert ou pratiqué..."),
		t({ "", "", "" }),

		-- Todos
		t("### ✅ Todos"),
		t({ "", "", "" }),
		t("- [ ] "),
		i(2, ""),
		t({ "", "", "" }),

		-- Idées
		t("### 💡 Idées"),
		t({ "", "", "" }),
		i(3, "Idées, réflexions, liens utiles..."),
		t({ "", "", "" }),

		-- Journal / humeur
		t("### 🌡️ Journal de bord"),
		t({ "", "", "" }),
		i(4, "Humeur, ressenti, ce qui m'a marqué..."),
		t({ "", "", "" }),
	}),
	s("obsidian", {
		-- Titre
		t({ "", "", "" }),
		t("# Note sur ... "),
		t({ "", "", "" }),

		-- Date (automatisée)
		t("**Date:** "),
		f(current_date),
		t({ "", "", "" }),

		-- Tags
		i(2, "**Tags**:"),
		t({ "", "", "" }),

		-- Références
		i(3, "Références:"),
		t({ "", "", "" }),
	}),
}
