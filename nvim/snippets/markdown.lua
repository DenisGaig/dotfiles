-- ~/.config/nvim/snippets/markdown.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
	s("daily", {
		t("---"),
		t({ "", "" }),
		t("date: "),
		f(function()
			return os.date("%Y-%m-%d")
		end, {}),
		t({ "", "" }),
		t("titre: "),
		i(1, "Titre de la note"),
		t({ "", "" }),
		t("humeur: "),
		i(2, "😊"),
		t({ "", "" }),
		t("meteo: "),
		i(3, "☀️"),
		t({ "", "" }),
		t("---"),
		t({ "", "", "" }),
		t("## 📓 Journal"),
		t({ "", "", "" }),
		i(4, "Ce que j'ai vécu aujourd'hui..."),
		t({ "", "", "" }),
		t("## 📝 Notes libres"),
		t({ "", "", "" }),
		i(5, "Idées, réflexions, liens..."),
		t({ "", "", "" }),
	}),
}
