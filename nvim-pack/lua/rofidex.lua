local M = {}

local FILETYPE_MAP = {
    -- code
    python     = { type = "code",     language = "python" },
    lua        = { type = "code",     language = "lua" },
    bash       = { type = "code",     language = "bash" },
    sh         = { type = "code",     language = "bash" },
    javascript = { type = "code",     language = "javascript" },
    typescript = { type = "code",     language = "typescript" },
    css        = { type = "code",     language = "css" },
    html       = { type = "code",     language = "html" },
    sql        = { type = "code",     language = "sql" },
    rust       = { type = "code",     language = "rust" },
    go         = { type = "code",     language = "go" },
    -- concept
    markdown   = { type = "concept",  language = "" },
    text       = { type = "concept",  language = "" },
    -- commande
    fish        = { type = "commande", language = "linux" },
}

function M.capture_selection(snippet_type, language)
    local tmp_file = os.tmpname()
    local f = io.open(tmp_file, "w")
    if not f then
        vim.notify("Rofidex: impossible de créer le fichier temporaire", vim.log.levels.ERROR)
        return
    end
    local text = vim.fn.getreg("v")
    f:write(text)
    f:close()

    local args = "--from-pipe"
    if language ~= "" then args = args .. " --language " .. language end
    if snippet_type ~= "" then args = args .. " --type " .. snippet_type end

    vim.fn.jobstart({
        "kitty", "--class", "rofidex-capture",
        "-e", "sh", "-c",
        string.format(
            -- "cat %s | /data/projets/rofidex/.venv/bin/python /data/projets/rofidex/capture.py %s; rm %s; echo 'Erreur? Appuie sur Entrée...'; read",
            "cat %s | /data/projets/rofidex/.venv/bin/python /data/projets/rofidex/capture.py %s; rm %s;",
            tmp_file,
            args,
            tmp_file
        )
    }, { detach = true })
end

-- Capturer la sélection et l'envoyer a la fonction capture de rofidex
vim.keymap.set("v", "<leader>rs", function()
    vim.cmd('normal! "vy')
    local text = vim.fn.getreg("v")

    if text == "" then
        vim.notify("Rofidex: sélection vide", vim.log.levels.WARN)
        return
    end

    local filetype = vim.bo.filetype
    local meta     = FILETYPE_MAP[filetype] or { type = "code", language = filetype }

    M.capture_selection(meta.type, meta.language)
end, { desc = "Rofidex: capturer la sélection" })

return M
