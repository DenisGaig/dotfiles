-- ~/.config/nvim/snippets/markdown.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("daily", {
		-- Emotions et besoins
		t({ "", "", "" }),
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
}
