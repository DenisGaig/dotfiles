-- ========================================================
-- 🔑 Open Daily Note
-- ========================================================

vim.keymap.set("n", "<leader>dn", function()
	vim.fn.jobstart({ os.getenv("HOME") .. "/.dotfiles/scripts/daily-note.sh" }, { detach = true })
end, { desc = "Open Daily Note" })

-- =========================================================
-- TABLE DES MATIÈRES MARKDOWN (markdown-toc)
-- Dépendance : pacman -S markdown-toc
-- Doc : https://github.com/jonschlinkert/markdown-toc
-- Vidéo : https://youtu.be/BVyrXsZ_ViA
-- =========================================================

-- Insère ou met à jour une table des matières dans le fichier markdown courant.
-- Si le marqueur <!-- toc --> est absent, la fonction l'insère avec les headings
-- spécifiés juste après le H1. markdown-toc se charge ensuite de générer la TOC.
--
-- @param heading2 string : ex. "## Contents"
-- @param heading3 string : ex. "### Table of contents"
local function update_markdown_toc(heading2, heading3)
	local path = vim.fn.expand("%") -- Chemin complet du fichier courant
	local bufnr = 0 -- 0 = buffer actif courant

	-- Sauvegarde de la vue courante pour préserver les folds
	vim.cmd("mkview")

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local toc_exists = false
	local frontmatter_end = 0

	-- Parcourt les lignes pour détecter :
	-- 1. Le frontmatter YAML (délimité par ---)
	-- 2. La présence du marqueur <!-- toc -->
	for i, line in ipairs(lines) do
		-- Détection du début de frontmatter (doit être à la ligne 1)
		if i == 1 and line:match("^---$") then
			for j = i + 1, #lines do
				if lines[j]:match("^---$") then
					frontmatter_end = j -- Mémorise la ligne de fin du frontmatter
					break
				end
			end
		end

		-- Si le marqueur TOC existe déjà, pas besoin d'insertion
		if line:match("^%s*<!%-%-%s*toc%s*%-%->%s*$") then
			toc_exists = true
			break
		end
	end

	-- Insertion du marqueur TOC si absent
	if not toc_exists then
		local insertion_line = 1 -- Point d'insertion par défaut

		if frontmatter_end > 0 then
			-- Avec frontmatter : cherche le H1 après la fin du frontmatter
			for i = frontmatter_end + 1, #lines do
				if lines[i]:match("^#%s+") then
					insertion_line = i + 1 -- Insère juste après le H1
					break
				end
			end
		else
			-- Sans frontmatter : cherche le H1 depuis le début
			for i, line in ipairs(lines) do
				if line:match("^#%s+") then
					insertion_line = i + 1 -- Insère juste après le H1
					break
				end
			end
		end

		-- Insère les headings et le marqueur <!-- toc --> à la position calculée
		vim.api.nvim_buf_set_lines(bufnr, insertion_line, insertion_line, false, { heading2, heading3, "<!-- toc -->" })
	end

	-- Sauvegarde silencieuse avant d'appeler markdown-toc
	-- (nécessaire si le marqueur vient d'être inséré)
	vim.cmd("silent write")

	-- Appel de markdown-toc avec "-" comme style de bullet
	vim.fn.system('markdown-toc --bullets "-" -i ' .. path)

	-- Recharge le buffer pour afficher la TOC générée
	vim.cmd("edit!")
	vim.cmd("silent write")

	vim.notify("TOC updated and file saved", vim.log.levels.INFO)

	-- Restaure la vue sauvegardée (folds inclus)
	vim.cmd("loadview")
end

-- 🔑 Keymaps pour déclencher la génération de TOC
-- <leader>ctt : TOC en anglais
vim.keymap.set("n", "<leader>ctt", function()
	update_markdown_toc("## Contents", "### Table of contents")
end, { desc = "Insert/update Markdown TOC (English)" })

-- ============================================================
-- MARKDOWN TASKS - inspiré de Linkarzu
-- ============================================================

-- 🔑 Alt+l : créer un bullet task sur la ligne courante (mode normal et insert)
vim.keymap.set("n", "<M-l>", function()
	local line = vim.api.nvim_get_current_line()
	if line:match("^%s*$") then
		vim.api.nvim_set_current_line("- [ ] ")
	else
		vim.api.nvim_set_current_line("- [ ] " .. line)
	end
	vim.cmd("startinsert!")
end, { desc = "Créer un bullet task" })

vim.keymap.set("i", "<M-l>", function()
	local line = vim.api.nvim_get_current_line()
	vim.api.nvim_set_current_line("- [ ] " .. line:match("^%s*(.-)%s*$"))
	vim.cmd("startinsert!")
end, { desc = "Créer un bullet task (insert)" })

-- ============================================================
-- 🔑 Alt+x : toggle task → envoie dans ## Completed tasks avec timestamp
-- ============================================================
vim.keymap.set("n", "<M-x>", function()
	local label_done = "done:"
	local timestamp = os.date("%y%m%d-%H%M")
	local tasks_heading = "## Completed tasks"

	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] -- 1-indexed
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local current_line = lines[row]

	-- Vérifie si c'est une tâche
	if not current_line:match("%- %[.%]") then
		vim.notify("Pas une tâche markdown", vim.log.levels.WARN)
		return
	end

	local is_done = current_line:match("%- %[x%]")
	local has_done_label = current_line:match("`" .. label_done)

	if is_done or has_done_label then
		-- UNTOGGLE : remet en todo, retire timestamp et label
		local restored = current_line:gsub("%- %[x%]", "- [ ]"):gsub("%s*`" .. label_done .. "[^`]*`", "")
		lines[row] = restored
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
	else
		-- TOGGLE : coche la tâche, ajoute label+timestamp, déplace dans Completed
		local done_line = current_line:gsub("%- %[ %]", "- [x]") .. " `" .. label_done .. " " .. timestamp .. "`"

		-- Retire la ligne courante
		table.remove(lines, row)

		-- Cherche ou crée ## Completed tasks
		local heading_row = nil
		for i, l in ipairs(lines) do
			if l:match("^## Completed tasks") then
				heading_row = i
				break
			end
		end

		if heading_row then
			-- Insère juste après le heading
			table.insert(lines, heading_row + 1, done_line)
		else
			-- Crée la section en bas du fichier
			table.insert(lines, "")
			table.insert(lines, tasks_heading)
			table.insert(lines, done_line)
		end

		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
		-- Replace le curseur sur la même ligne
		vim.api.nvim_win_set_cursor(0, { math.min(row, #lines), 0 })
	end

	vim.cmd("silent! write")
end, { desc = "Toggle task markdown + déplace dans Completed" })
