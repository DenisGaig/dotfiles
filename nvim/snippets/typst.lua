-- nvim/snippets/typst.lua
-- Snippets LuaSnip pour la création de tableaux en Typst.

local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node

return {

    -- Trigger: tbl (tableau simple avec en-tête)
    -- Résultat: #table(columns: (auto, auto), table.header[...][...], [...][...],)
    s("tbl", {
        t "#table(",
        t { "", "  columns: (" },
        i(1, "auto, auto"),
        t { "),", "  table.header[" },
        i(2, "Titre 1"),
        t "][",
        i(3, "Titre 2"),
        t { "],", "  [" },
        i(4, "Cellule 1"),
        t "],[",
        i(5, "Cellule 2"),
        t { "],", ")" },
        i(0),
    }),

    -- Trigger: tblfull (tableau large, dernière colonne extensible)
    -- Résultat: #table(columns: (auto, auto, 1fr), ...) pour les tableaux qui prennent toute la largeur.
    s("tblfull", {
        t "#table(",
        t { "", "  columns: (auto, auto, 1fr)," },
        t { "", "  table.header[" },
        i(1, "Colonne 1"),
        t "][",
        i(2, "Colonne 2"),
        t "][",
        i(3, "Description"),
        t { "],", "  [" },
        i(4, "Donnée 1"),
        t "][",
        i(5, "Donnée 2"),
        t "][",
        i(6, "Description détaillée"),
        t { "],", ")" },
        i(0),
    }),

    -- Trigger: tblbook (style Booktabs : lignes horizontales uniquement)
    -- Résultat: Tableau propre avec #table.hline pour les séparateurs.
    s("tblbook", {
        t "#table(",
        t { "", "  columns: 3," },
        t { "", "  stroke: none," },
        t { "", "  align: center + horizon," },
        t { "", "  table.hline(stroke: 1.5pt)," },
        t { "", "  table.header[" },
        i(1, "En-tête 1"),
        t "][",
        i(2, "En-tête 2"),
        t "][",
        i(3, "En-tête 3"),
        t { "],", "  table.hline(stroke: 0.5pt),", "  [" },
        i(4, "Donnée 1"),
        t "][",
        i(5, "Donnée 2"),
        t "][",
        i(6, "Donnée 3"),
        t { "],", "  table.hline(stroke: 1.5pt),", ")" },
        i(0),
    }),

    -- Trigger: tblrow (ligne de tableau avec rayures automatiques)
    -- Résultat: Un tableau avec fond rayé (fill: (_, y) => ...)
    s("tblstripe", {
        t "#table(",
        t { "", "  columns: (" },
        i(1, "auto, auto, 1fr"),
        t { "),", "  fill: (_, y) => if calc.odd(y) { luma(240) }," },
        t { "", "  table.header[" },
        i(2, "Colonne A"),
        t "][",
        i(3, "Colonne B"),
        t "][",
        i(4, "Colonne C"),
        t { "],", "  [" },
        i(5, "valeur 1"),
        t "][",
        i(6, "valeur 2"),
        t "][",
        i(7, "valeur 3"),
        t { "],", "  [" },
        i(8, "valeur 4"),
        t "][",
        i(9, "valeur 5"),
        t "][",
        i(10, "valeur 6"),
        t { "],", ")" },
        i(0),
    }),

    -- Trigger: tblspan (tableau avec cellule fusionnée)
    -- Résultat: Utilisation de #table.cell(colspan: N)[...]
    s("tblspan", {
        t "#table(",
        t { "", "  columns: 3," },
        t { "", "  table.cell(colspan: 3, align: center)[" },
        i(1, "Titre fusionné"),
        t { "],", "  [" },
        i(2, "A1"),
        t "][",
        i(3, "B1"),
        t "][",
        i(4, "C1"),
        t { "],", "  [" },
        i(5, "A2"),
        t "][",
        i(6, "B2"),
        t "][",
        i(7, "C2"),
        t { "],", ")" },
        i(0),
    }),

    -- Trigger: tblcsv (lecture de données depuis un CSV)
    -- Résultat: Génère un tableau à partir d'un fichier CSV.
    s("tblcsv", {
        t '#let data = csv("',
        i(1, "data.csv"),
        t { '")', "#table(", "  columns: " },
        i(2, "data.first().len()"),
        t { ",", "  table.header(..data.first().map(str)),", "  ..data.slice(1).flatten(),", ")" },
        i(0),
    }),
}
