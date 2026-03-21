-- ~/.config/nvim/lua/emotions/init.lua
-- Picker Telescope pour les émotions et besoins (Comitys)
-- Usage :
--   :EmotionPick   ou  <leader>fe   → chercher une émotion, insère le mot
--   :BesoinPick    ou  <leader>fb   → chercher un besoin, insère le mot
--   :EmotionBesoin ou  <leader>fE   → chercher une émotion, puis choisir
--                                     parmi ses besoins associés

local M = {}

-- Dépendances Telescope
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local entry_display = require("telescope.pickers.entry_display")

-- Charge la base de données en lisant dans ~/.dotfiles/nvim/lua/emotions/data
local data = require("emotions.data")

-- ─────────────────────────────────────────────
-- Utilitaire : insère un mot à la position curseur
-- ─────────────────────────────────────────────
local function insert_word(word)
	local unpack = table.unpack or unpack
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	-- Insère le mot à la position du curseur
	local new_line = line:sub(1, col) .. word .. line:sub(col + 1)
	vim.api.nvim_set_current_line(new_line)
	-- Replace le curseur après le mot inséré
	vim.api.nvim_win_set_cursor(0, { row, col + #word })
end

-- ─────────────────────────────────────────────
-- Previewer : affiche les infos d'une émotion
-- ─────────────────────────────────────────────
local function emotion_previewer()
	return previewers.new_buffer_previewer({
		title = "Détails",
		define_preview = function(self, entry)
			local e = entry.value
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

			vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
		end,
	})
end

-- ─────────────────────────────────────────────
-- Previewer : affiche les infos d'un besoin
-- ─────────────────────────────────────────────
local function besoin_previewer()
	return previewers.new_buffer_previewer({
		title = "Détails",
		define_preview = function(self, entry)
			local b = entry.value
			local lines = {
				"  " .. b.full,
				"",
				"  Synonymes",
				"  ─────────",
			}
			for _, s in ipairs(b.synonyms) do
				table.insert(lines, "  • " .. s)
			end
			vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
		end,
	})
end

-- ─────────────────────────────────────────────
-- PICKER 1 : Émotions
-- ─────────────────────────────────────────────
function M.pick_emotion(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = " Émotions",
			finder = finders.new_table({
				results = data.emotions,

				entry_maker = function(e)
					local displayer = entry_display.create({
						separator = " ",
						items = {
							{ width = 18 }, -- mot principal
							{ width = 14 }, -- synonyme 1
							{ width = 14 }, -- synonyme 2
							{ remaining = true },
						},
					})
					return {
						value = e,
						display = function()
							return displayer({
								e.main,
								e.synonyms[1] or "",
								e.synonyms[2] or "",
								e.synonyms[3] or "",
							})
						end,
						ordinal = e.main .. " " .. table.concat(e.synonyms, " "),
					}
				end,

				-- entry_maker = function(e)
				-- 	-- La ligne affichée dans le picker
				-- 	local syns = table.concat(e.synonyms, "  ")
				-- 	return {
				-- 		value = e,
				-- 		display = string.format("%-18s  %s", e.main, syns),
				-- 		ordinal = e.main .. " " .. table.concat(e.synonyms, " "),
				-- 	}
				-- end,
			}),
			sorter = conf.generic_sorter(opts),
			previewer = emotion_previewer(),
			attach_mappings = function(prompt_bufnr)
				-- Enter → insère le mot principal
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection then
						insert_word(selection.value.main)
					end
				end)
				return true
			end,
		})
		:find()
end

-- ─────────────────────────────────────────────
-- PICKER 2 : Besoins
-- ─────────────────────────────────────────────
function M.pick_besoin(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "  Besoins",
			finder = finders.new_table({
				results = data.besoins,

				entry_maker = function(b)
					local displayer = entry_display.create({
						separator = " ",
						items = {
							{ width = 27 }, -- "besoin de X"
							{ width = 14 }, -- synonyme 1
							{ width = 14 }, -- synonyme 2
							{ remaining = true },
						},
					})
					return {
						value = b,
						display = function()
							return displayer({
								b.full,
								b.synonyms[1] or "",
								b.synonyms[2] or "",
								b.synonyms[3] or "",
							})
						end,
						ordinal = b.full .. " " .. table.concat(b.synonyms, " "),
					}
				end,
				-- entry_maker = function(b)
				-- 	local syns = table.concat(b.synonyms, "  ")
				-- 	return {
				-- 		value = b,
				-- 		display = string.format("%-20s  %s", b.full, syns),
				-- 		ordinal = b.full .. " " .. table.concat(b.synonyms, " "),
				-- 	}
				-- end,
			}),
			sorter = conf.generic_sorter(opts),
			previewer = besoin_previewer(),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection then
						-- Insère le mot principal du besoin (ex: "tendresse")
						insert_word(selection.value.main)
					end
				end)
				return true
			end,
		})
		:find()
end

-- ─────────────────────────────────────────────
-- PICKER 3 : Émotion → Besoins associés
-- Sélectionne une émotion, puis ouvre un second
-- picker sur ses besoins associés uniquement
-- ─────────────────────────────────────────────
function M.pick_emotion_then_besoin(opts)
	opts = opts or {}

	-- Index des besoins par id pour lookup rapide
	local besoins_by_id = {}
	for _, b in ipairs(data.besoins) do
		besoins_by_id[b.id] = b
	end

	pickers
		.new(opts, {
			prompt_title = " Émotion → Besoins",
			finder = finders.new_table({
				results = data.emotions,
				entry_maker = function(e)
					local nb = #e.needs
					local needs_preview = nb > 0 and ("→ " .. table.concat(e.needs, ", ")) or "→ (aucun besoin associé)"
					return {
						value = e,
						display = string.format("%-18s  %s", e.main, needs_preview),
						ordinal = e.main .. " " .. table.concat(e.synonyms, " "),
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			previewer = emotion_previewer(),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if not selection then
						return
					end

					local emotion = selection.value

					-- Récupère les besoins associés à cette émotion
					local associated = {}
					for _, nid in ipairs(emotion.needs_ids) do
						if besoins_by_id[nid] then
							table.insert(associated, besoins_by_id[nid])
						end
					end

					if #associated == 0 then
						vim.notify("Aucun besoin associé à : " .. emotion.main, vim.log.levels.INFO)
						return
					end

					-- Ouvre un second picker sur les besoins associés
					pickers
						.new({}, {
							prompt_title = "  Besoins liés à « " .. emotion.main .. " »",
							finder = finders.new_table({
								results = associated,
								entry_maker = function(b)
									local syns = table.concat(b.synonyms, "  ")
									return {
										value = b,
										display = string.format("%-20s  %s", b.full, syns),
										ordinal = b.full .. " " .. table.concat(b.synonyms, " "),
									}
								end,
							}),
							sorter = conf.generic_sorter({}),
							previewer = besoin_previewer(),
							attach_mappings = function(prompt_bufnr2)
								actions.select_default:replace(function()
									local sel2 = action_state.get_selected_entry()
									actions.close(prompt_bufnr2)
									if sel2 then
										insert_word(sel2.value.main)
									end
								end)
								return true
							end,
						})
						:find()
				end)
				return true
			end,
		})
		:find()
end

-- ─────────────────────────────────────────────
-- Commandes Vim
-- ─────────────────────────────────────────────
vim.api.nvim_create_user_command("EmotionPick", M.pick_emotion, {})
vim.api.nvim_create_user_command("BesoinPick", M.pick_besoin, {})
vim.api.nvim_create_user_command("EmotionBesoin", M.pick_emotion_then_besoin, {})

-- ─────────────────────────────────────────────
-- Keymaps (Insert + Normal mode)
-- Préfixe <leader>f pour "feelings"
-- ─────────────────────────────────────────────
local map = vim.keymap.set
local opts_km = { noremap = true, silent = true }
--
-- -- Normal mode
-- map("n", "<leader>fe", M.pick_emotion, vim.tbl_extend("force", opts_km, { desc = "Picker : émotions" }))
-- map("n", "<leader>fb", M.pick_besoin, vim.tbl_extend("force", opts_km, { desc = "Picker : besoins" }))
-- map("n", "<leader>fE", M.pick_emotion_then_besoin, vim.tbl_extend("force", opts_km, { desc = "Picker : émotion → besoins" }))
--
-- -- Insert mode : quitte insert, insère, revient en insert
-- map("i", "<M-e>", "<Esc>:lua require('emotions').pick_emotion()<CR>", vim.tbl_extend("force", opts_km, { desc = "Picker : émotions (insert)" }))
-- map("i", "<M-n>", "<Esc>:lua require('emotions').pick_besoin()<CR>", vim.tbl_extend("force", opts_km, { desc = "Picker : besoins (insert)" }))
--
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		map("n", "<leader>fe", M.pick_emotion, vim.tbl_extend("force", opts_km, { desc = "Picker : émotions", buffer = buf }))
		map("n", "<leader>fb", M.pick_besoin, vim.tbl_extend("force", opts_km, { desc = "Picker : besoins", buffer = buf }))
		map("n", "<leader>fE", M.pick_emotion_then_besoin, vim.tbl_extend("force", opts_km, { desc = "Picker : émotion → besoins", buffer = buf }))
		map("i", "<M-e>", "<Esc>:lua require('emotions').pick_emotion()<CR>", vim.tbl_extend("force", opts_km, { desc = "Picker : émotions (insert)", buffer = buf }))
		map("i", "<M-n>", "<Esc>:lua require('emotions').pick_besoin()<CR>", vim.tbl_extend("force", opts_km, { desc = "Picker : besoins (insert)", buffer = buf }))
	end,
})

return M
