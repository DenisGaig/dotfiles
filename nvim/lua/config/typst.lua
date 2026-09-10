local M = {}

local typst_job = nil
local typst_file = nil

-- Cherche la racine Git en remontant depuis le fichier courant
local function git_root()
    local git_dir = vim.fs.find(".git", {
        path = vim.fn.expand "%:p:h",
        upward = true,
        type = "directory",
    })[1]

    if not git_dir then
        return nil
    end

    return vim.fs.dirname(git_dir)
end

function M.watch()
    local file = vim.fn.expand "%:p"

    -- Si un watcher surveille déjà ce fichier
    if typst_job and vim.fn.jobwait({ typst_job }, 0)[1] == -1 and typst_file == file then
        vim.notify("Typst watch est déjà actif", vim.log.levels.INFO)
        return
    end

    -- Si un watcher surveille un autre fichier, on l'arrête
    if typst_job and vim.fn.jobwait({ typst_job }, 0)[1] == -1 then
        vim.fn.jobstop(typst_job)
        typst_job = nil
        typst_file = nil
    end

    local root = git_root()

    if not root then
        vim.notify("Racine Git introuvable", vim.log.levels.ERROR)
        return
    end

    typst_job = vim.fn.jobstart({
        "typst",
        "watch",
        "--root",
        root,
        file,
    }, {
        on_exit = function()
            typst_job = nil
            typst_file = nil
        end,
    })

    if typst_job <= 0 then
        typst_job = nil
        typst_file = nil
        vim.notify("Impossible de lancer Typst", vim.log.levels.ERROR)
        return
    end

    typst_file = file

    vim.notify("Typst watch lancé : " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
end

function M.preview()
    local pdf = vim.fn.expand "%:p:r" .. ".pdf"

    if vim.fn.filereadable(pdf) == 0 then
        vim.notify("PDF introuvable : " .. pdf, vim.log.levels.WARN)
        return
    end

    vim.fn.jobstart({
        "zathura",
        "--fork",
        pdf,
    }, {
        detach = true,
    })
end

return M
