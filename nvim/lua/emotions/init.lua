-- ~/.config/nvim-pack/lua/emotions/init.lua
-- Picker mini.pick pour les émotions et besoins (Comitys)
-- Usage :
--   :EmotionPick   ou  <leader>fe   → chercher une émotion, insère le mot
--   :BesoinPick    ou  <leader>fb   → chercher un besoin, insère le mot
--   :EmotionBesoin ou  <leader>fE   → chercher une émotion, puis choisir
--                                     parmi ses besoins associés

local M = {}

local data = require "emotions.data"

-- ─────────────────────────────────────────────
-- Utilitaire : insère un mot à la position curseur
-- ─────────────────────────────────────────────
local function insert_word(word)
    local unpack = table.unpack or unpack
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local new_line = line:sub(1, col) .. word .. line:sub(col + 1)
    vim.api.nvim_set_current_line(new_line)
    vim.api.nvim_win_set_cursor(0, { row, col + #word })
end

-- ─────────────────────────────────────────────
-- Utilitaire : écrit les lignes de preview dans un buffer
-- ─────────────────────────────────────────────
local function set_preview_lines(buf_id, lines)
    vim.bo[buf_id].modifiable = true
    vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
    vim.bo[buf_id].modifiable = false
end

-- ─────────────────────────────────────────────
-- Preview d'une émotion
-- ─────────────────────────────────────────────
local function emotion_preview(buf_id, item)
    local e = item
    local lines = {
        "  " .. e.main,
        "",
        "  Synonymes",
        "  ─────────",
    }
    for _, s in ipairs(e.synonyms) do
        table.insert(lines, "  • " .. s)
    end
    table.insert(lines, "")
    table.insert(lines, "  Besoins associés")
    table.insert(lines, "  ─────────────────")
    if #e.needs == 0 then
        table.insert(lines, "  (aucun)")
    else
        for _, n in ipairs(e.needs) do
            table.insert(lines, "  • besoin de " .. n)
        end
    end
    table.insert(lines, "")
    table.insert(lines, "  Blessure(s) possible(s)")
    table.insert(lines, "  ────────────────────────")
    if e.wounds and #e.wounds > 0 then
        for _, w in ipairs(e.wounds) do
            table.insert(lines, "  ◦ " .. w)
        end
    else
        table.insert(lines, "  (aucune association)")
    end
    set_preview_lines(buf_id, lines)
end

-- ─────────────────────────────────────────────
-- Preview d'un besoin
-- ─────────────────────────────────────────────
local function besoin_preview(buf_id, item)
    local b = item
    local lines = {
        "  " .. b.full,
        "",
        "  Synonymes",
        "  ─────────",
    }
    for _, s in ipairs(b.synonyms) do
        table.insert(lines, "  • " .. s)
    end
    set_preview_lines(buf_id, lines)
end

-- ─────────────────────────────────────────────
-- Fonction clé : ordinal pour le matching fuzzy
-- mini.pick matche sur la valeur retournée par
-- source.items si ce sont des strings, ou via
-- un champ "text" si ce sont des tables.
-- On wrappe donc chaque entrée pour exposer
-- un champ "text" searchable.
-- ─────────────────────────────────────────────
local function emotions_as_items()
    local items = {}
    for _, e in ipairs(data.emotions) do
        table.insert(items, {
            text = e.main .. " " .. table.concat(e.synonyms, " "),
            _data = e,
        })
    end
    return items
end

local function besoins_as_items(list)
    list = list or data.besoins
    local items = {}
    for _, b in ipairs(list) do
        table.insert(items, {
            text = b.full .. " " .. table.concat(b.synonyms, " "),
            _data = b,
        })
    end
    return items
end

-- ─────────────────────────────────────────────
-- show() générique : mini.pick passe les items
-- filtrés (qui ont chacun un champ text + _data)
-- ─────────────────────────────────────────────
local function pad(s, width)
    local visual_len = vim.fn.strdisplaywidth(s)
    return s .. string.rep(" ", math.max(0, width - visual_len))
end

local function make_emotion_show()
    return function(buf_id, items, query)
        local win = vim.fn.bufwinid(buf_id)
        local win_width = win ~= -1 and vim.api.nvim_win_get_width(win) or 80
        local col_w = math.floor((win_width - 6) / 4)

        -- Remplace temporairement item.text par la ligne formatée
        local originals = {}
        for i, item in ipairs(items) do
            originals[i] = item.text
            local e = item._data
            local cols = { e.main, e.synonyms[1] or "", e.synonyms[2] or "", e.synonyms[3] or "" }
            local parts = {}
            for _, c in ipairs(cols) do
                table.insert(parts, pad(c, col_w))
            end
            item.text = table.concat(parts, "  ")
        end

        MiniPick.default_show(buf_id, items, query)

        -- Restaure les text originaux pour que le matching fuzzy reste correct
        for i, item in ipairs(items) do
            item.text = originals[i]
        end
    end
end

local function make_besoin_show()
    return function(buf_id, items, query)
        -- Largeur dispo dans la fenêtre picker
        local win = vim.fn.bufwinid(buf_id)
        local win_width = win ~= -1 and vim.api.nvim_win_get_width(win) or 80
        local col_w = math.floor((win_width - 6) / 4) -- 4 colonnes, séparateurs compris

        local originals = {}
        for i, item in ipairs(items) do
            originals[i] = item.text
            local b = item._data
            local cols = { b.full, b.synonyms[1] or "", b.synonyms[2] or "", b.synonyms[3] or "" }
            local parts = {}
            for _, c in ipairs(cols) do
                -- table.insert(parts, string.format("%-" .. col_w .. "s", c))
                table.insert(parts, pad(c, col_w))
            end
            item.text = table.concat(parts, "  ")
        end

        MiniPick.default_show(buf_id, items, query)

        -- Restaure les text originaux pour que le matching fuzzy reste correct
        for i, item in ipairs(items) do
            item.text = originals[i]
        end
    end
end

-- ─────────────────────────────────────────────
-- PICKER 1 : Émotions
-- ─────────────────────────────────────────────
function M.pick_emotion()
    -- Sauvegarde de la fenêtre cible AVANT que mini.pick l'écrase
    local target_win = vim.api.nvim_get_current_win()

    MiniPick.start {
        source = {
            name = " Émotions",
            items = emotions_as_items(),
            show = make_emotion_show(),
            preview = function(buf_id, item)
                emotion_preview(buf_id, item._data)
            end,
            choose = function(item)
                if not item then
                    return
                end
                -- Restaure la fenêtre cible pour l'insertion
                vim.api.nvim_set_current_win(target_win)
                insert_word(item._data.main)
            end,
        },
    }
end

-- ─────────────────────────────────────────────
-- PICKER 2 : Besoins
-- ─────────────────────────────────────────────
function M.pick_besoin()
    local target_win = vim.api.nvim_get_current_win()

    MiniPick.start {
        source = {
            name = "  Besoins",
            items = besoins_as_items(),
            show = make_besoin_show(),
            preview = function(buf_id, item)
                besoin_preview(buf_id, item._data)
            end,
            choose = function(item)
                if not item then
                    return
                end
                vim.api.nvim_set_current_win(target_win)
                insert_word(item._data.main)
            end,
        },
    }
end

-- ─────────────────────────────────────────────
-- PICKER 3 : Émotion → Besoins associés
-- ─────────────────────────────────────────────
function M.pick_emotion_then_besoin()
    local target_win = vim.api.nvim_get_current_win()

    -- Index des besoins par id
    local besoins_by_id = {}
    for _, b in ipairs(data.besoins) do
        besoins_by_id[b.id] = b
    end

    MiniPick.start {
        source = {
            name = " Émotion → Besoins",
            items = emotions_as_items(),
            show = make_emotion_show(),
            preview = function(buf_id, item)
                emotion_preview(buf_id, item._data)
            end,
            choose = function(item)
                if not item then
                    return
                end
                local emotion = item._data

                -- Collecte les besoins associés
                local associated = {}
                for _, nid in ipairs(emotion.needs_ids or {}) do
                    if besoins_by_id[nid] then
                        table.insert(associated, besoins_by_id[nid])
                    end
                end

                if #associated == 0 then
                    vim.notify("Aucun besoin associé à : " .. emotion.main, vim.log.levels.INFO)
                    return
                end

                -- Second picker sur les besoins associés
                -- vim.schedule pour éviter d'ouvrir un picker depuis choose()
                vim.schedule(function()
                    MiniPick.start {
                        source = {
                            name = "  Besoins liés à « " .. emotion.main .. " »",
                            items = besoins_as_items(associated),
                            show = make_besoin_show(),
                            preview = function(buf_id2, item2)
                                besoin_preview(buf_id2, item2._data)
                            end,
                            choose = function(item2)
                                if not item2 then
                                    return
                                end
                                vim.api.nvim_set_current_win(target_win)
                                insert_word(item2._data.main)
                            end,
                        },
                    }
                end)
            end,
        },
    }
end

-- ─────────────────────────────────────────────
-- Commandes Vim
-- ─────────────────────────────────────────────
vim.api.nvim_create_user_command("EmotionPick", M.pick_emotion, {})
vim.api.nvim_create_user_command("BesoinPick", M.pick_besoin, {})
vim.api.nvim_create_user_command("EmotionBesoin", M.pick_emotion_then_besoin, {})

-- ─────────────────────────────────────────────
-- Keymaps (Insert + Normal mode, markdown/text)
-- ─────────────────────────────────────────────
local map = vim.keymap.set
local opts_km = { noremap = true, silent = true }

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        map(
            "n",
            "<leader>fe",
            M.pick_emotion,
            vim.tbl_extend("force", opts_km, { desc = "Picker : émotions", buffer = buf })
        )
        map(
            "n",
            "<leader>fb",
            M.pick_besoin,
            vim.tbl_extend("force", opts_km, { desc = "Picker : besoins", buffer = buf })
        )
        map(
            "n",
            "<leader>fE",
            M.pick_emotion_then_besoin,
            vim.tbl_extend("force", opts_km, { desc = "Picker : émotion → besoins", buffer = buf })
        )
        map(
            "i",
            "<M-e>",
            "<Esc>:lua require('emotions').pick_emotion()<CR>",
            vim.tbl_extend("force", opts_km, { desc = "Picker : émotions (insert)", buffer = buf })
        )
        map(
            "i",
            "<M-n>",
            "<Esc>:lua require('emotions').pick_besoin()<CR>",
            vim.tbl_extend("force", opts_km, { desc = "Picker : besoins (insert)", buffer = buf })
        )
    end,
})

return M
