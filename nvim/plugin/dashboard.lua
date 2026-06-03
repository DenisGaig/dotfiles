-- ~/.config/nvim/lua/plugins/dashboard.lua

local function center(str)
    local width = vim.api.nvim_get_option "columns"
    local padding = math.floor((width - vim.fn.strdisplaywidth(str)) / 2)
    return string.rep(" ", padding) .. str
end

local function session_exists()
    local ok, autosession = pcall(require, "auto-session")
    if not ok then
        return false
    end
    return autosession.session_exists_for_cwd()
end

local function open_dashboard()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(buf)

    local has_session = session_exists()

    local logo = {
        "",
        center [[                                                                       ]],
        center [[                                                                       ]],
        center [[                                                                       ]],
        center [[                                                                       ]],
        center [[                                                                     ]],
        center [[       ████ ██████           █████      ██                     ]],
        center [[      ███████████             █████                             ]],
        center [[      █████████ ███████████████████ ███   ███████████   ]],
        center [[     █████████  ███    █████████████ █████ ██████████████   ]],
        center [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        center [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        center [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        center [[                                                                       ]],
        center [[                                                                       ]],
        center "[  DG the sylve guardian  ]",
    }

    local body

    if has_session then
        body = {

            "",
            center("Session : " .. vim.fn.getcwd()),
            "",
            "                   [r]  Restaurer la session",
            "                   [q]  Quitter",
            "",
        }
    else
        body = {
            "",
            center "Neovim",
            "",
            "                   [f]  Trouver un fichier",
            "                   [r]  Fichiers récents",
            "                   [g]  Grep",
            "                   [e]  Nouveau fichier",
            "                   [q]  Quitter",
            "",
        }
    end

    -- Fusion logo + contenu
    local lines = {}
    vim.list_extend(lines, logo)
    vim.list_extend(lines, body)

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].buftype = "nofile"

    -- 1. Définir le groupe de couleur (Highlight Group)
    vim.api.nvim_set_hl(0, "DashboardLogo", { default = true })

    -- 2. Créer un namespace pour appliquer la couleur
    local ns_id = vim.api.nvim_create_namespace "dashboard_logo"

    -- 3. Appliquer le highlight sur tout le logo (de la ligne 0 à la fin du tableau logo)
    -- -1 signifie "jusqu'à la fin de la ligne"
    vim.api.nvim_buf_set_extmark(buf, ns_id, 0, 0, {
        end_row = #logo - 1,
        -- end_col = -1,
        hl_group = "DashboardLogo",
        hl_eol = true,
    })

    -- 4. Mettre les touches de raccourci dans une autre couleur
    vim.api.nvim_set_hl(0, "DashboardKey", { default = true })
    local key_ns = vim.api.nvim_create_namespace "dashboard_keys"

    for i, line in ipairs(body) do
        local start_idx, end_idx = line:find "%[.%]"
        if start_idx then
            -- Note: on utilise aussi hl_eol ici au cas où tu voudrais
            -- mettre un fond (bg) à tes touches plus tard.
            vim.api.nvim_buf_set_extmark(buf, key_ns, #logo + i - 1, start_idx - 1, {
                end_col = end_idx,
                hl_group = "DashboardKey",
                hl_eol = false, -- Pas besoin de coloriser la fin de la ligne pour une touche
            })
        end
    end

    local opts = { noremap = true, silent = true, buffer = buf }

    if has_session then
        vim.keymap.set("n", "r", "<cmd>AutoSession restore<cr>", opts)
    else
        vim.keymap.set("n", "f", "<cmd>lua MiniPick.builtin.files()<cr>", opts)
        vim.keymap.set("n", "r", "<cmd>lua MiniExtra.pickers.oldfiles()<cr>", opts)
        vim.keymap.set("n", "g", "<cmd>lua MiniPick.builtin.grep_live()<cr>", opts)
        vim.keymap.set("n", "e", "<cmd>enew<cr>", opts)
    end

    vim.keymap.set("n", "q", "<cmd>qa<cr>", opts)
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 then
            open_dashboard()
        end
    end,
})
