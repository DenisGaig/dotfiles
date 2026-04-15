-- ~/.config/nvim/snippets/markdown.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep

-- Fonction pour générer la date actuelle (format: 2026-03-26)
local function current_date()
	return os.date("%Y-%m-%d")
end

-- Fonction pour récupérer le presse-papier
local function clipboard()
	return vim.fn.getreg("+")
end

return {
	-- Snippet pour ma daily note
	s("daily", {

		-- Apprentissages
		t("### Apprentissages / Réalisations"),
		t({ "", "", "" }),
		i(1, "Ce que j'ai découvert ou pratiqué..."),
		t({ "", "", "" }),

		-- Idées
		t("### Idées / Réflexions "),
		t({ "", "", "" }),
		i(3, "Idées, réflexions, liens utiles..."),
		t({ "", "", "" }),

		-- Todos
		t("### Todos"),
		t({ "", "", "" }),
		t("- [ ] "),
		i(2, ""),
		t({ "", "", "" }),
	}),

	-- Snippet pour mon journal project
	s("journal", {
		-- Emotions et besoins
		t({ "", "", "" }),
		t("- 😢 Emotions: "),
		i(1, "Je me sens..."),
		t({ "", "" }),
		t("- 💙 Besoins: "),
		i(2, "J'ai besoin..."),
		t({ "", "", "" }),
	}),

	-- Snippet pour mes notes obsidian
	s("obsidian", {
		-- Titre
		t({ "", "", "" }),
		t("# Note sur "),
		i(1, "Titre"),
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

	-- Snippet pour le frontmatter des cours
	s("cours", {
		t("---"),
		t({ "", "" }),
		t("title: "),
		i(1, "Nom du cours"),
		t({ "", "" }),
		t("description: "),
		i(2, "Description du cours"),
		t({ "", "" }),
		t("image: "),
		i(3, "URL de l'image optionnelle"),
		t({ "", "" }),
		t("tags: "),
		i(4, "Tags du cours"),
		t({ "", "" }),
		t("created: "),
		i(5),
		t({ "", "" }),
		t("updated: "),
		i(6),
		t({ "", "" }),
		t("order: "),
		i(7, "Ordre d'affichage"),
		t({ "", "" }),
		t("niveau: "),
		i(8, "bts ou bac-pro"),
		t({ "", "" }),
		t("matiere: "),
		i(9, "physique ou maths"),
		t({ "", "" }),
		t("draft:"),
		i(10, "true ou false"),
		t({ "", "" }),
		t("---"),
	}),

	-- Snippet : Lien YouTube (ou web) depuis le presse-papier
	-- Usage : tapez "linkc" + Tab
	s("linkc", { t("["), i(1, "Titre"), t("]("), f(clipboard, {}), t(")") }),

	-- Snippet : Formula KaTeX pour mdx astro
	s("formula", {
		t({ "<Formula", '  title="' }),
		i(1, "Titre de la formule"),
		t({ '">', '  <span slot="formula">$$ ' }),
		i(2, "formule"),
		t({ " $$</span>", '  <span slot="legend">' }),
		i(3, "légende avec $LaTex$"),
		t({ "</span>", "</Formula>" }),
	}),

	-- Formula KaTeX inline (petite formule)
	s("formi", {
		t("$"),
		i(1, "formule"),
		t("$"),
	}),

	-- Snippet : Coller une image depuis le clipboard (wl-paste) et générer l'import Astro Image
	s("imga", {
		t("import "),
		i(1, "nomImage"),
		t(' from "@/'),
		f(function()
			local project_root = "/data/projets/astro-cours"
			local script = project_root .. "/scripts/paste-img.sh"
			local mdx_path = vim.fn.expand("%:p")

			local result =
				vim.fn.system("bash --norc --noprofile " .. vim.fn.shellescape(script) .. " " .. vim.fn.shellescape(mdx_path))

			-- Prendre uniquement la dernière ligne non vide
			local chemin = ""
			for line in result:gmatch("[^\n]+") do
				if line:match("assets/") then
					chemin = line:gsub("%s+$", "")
				end
			end

			return chemin
		end, {}),
		t('"'),
		t({ "", "" }), -- saut de ligne
		t({ "", "" }), -- saut de ligne
		t("<Image src={"),
		rep(1), -- répète le nomImage saisi au noeud i(1)
		t('} alt="'),
		i(2, "description"),
		t('" />'),
	}),
}
