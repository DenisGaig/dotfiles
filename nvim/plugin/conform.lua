local add_on_event = require("vim-pack").add_on_event

local function python_project_root()
    local markers = { "uv.lock", "pyproject.toml" }
    local file = vim.api.nvim_buf_get_name(0)

    if file == "" then
        return nil
    end

    local start = vim.fs.dirname(file)
    local root = vim.fs.root(start, markers)

    return root
end

-- add_on_event("BufWritePre", {
add_on_event({ "BufReadPre", "BufNewFile" }, {
    {
        src = "stevearc/conform.nvim",
        opts = {
            -- Leave me alone.
            notify_on_error = false,
            notify_no_formatters = false,
            formatters_by_ft = {
                astro = { "prettier", timeout_ms = 3000, lsp_format = "fallback" },
                css = { "prettier" },
                -- Via LSP (clang) comme Maria SolOS
                -- c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
                -- direct clang_format — plus fiable, indépendant du LSP
                c = { "clang_format" },
                --go = { name = 'gopls', timeout_ms = 500, lsp_format = 'prefer' },
                --java = { 'palantir-java-format' },
                html = { "prettier" },
                javascript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
                javascriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
                json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
                jsonc = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
                less = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
                mdx = { "prettier", lsp_format = "fallback" },
                typst = { "typstyle" },
                nix = { "alejandra" },
                python = { "isort", "black" },
                rust = { name = "rust_analyzer", timeout_ms = 500, lsp_format = "prefer" },
                --scss = { 'prettier' },
                sh = { "shfmt" },
                typescript = { "prettier", name = "dprint", timeout_ms = 1000, lsp_format = "fallback" },
                typescriptreact = { "prettier", name = "dprint", timeout_ms = 1000, lsp_format = "fallback" },
                yaml = { "prettier" },
                -- For filetypes without a formatter:
                ["_"] = { "trim_whitespace", "trim_newlines" },
            },
            format_on_save = function()
                -- Don't format when minifiles is open, since that triggers the "confirm without
                -- synchronization" message.
                if vim.g.minifiles_active then
                    return nil
                end

                -- Skip formatting if triggered from my special save command.
                if vim.g.skip_formatting then
                    vim.g.skip_formatting = false
                    return nil
                end

                -- Stop if we disabled auto-formatting.
                if not vim.g.autoformat then
                    return nil
                end

                return {}
            end,
            formatters = {
                -- Require a Prettier configuration file to format.
                prettier = { require_cwd = true },

                -- Utiliser les outils du projet Python courant avec uv.
                isort = {
                    command = "uv", -- Utilise uv, disponible globalement, plutôt que de chercher directement black ou isort.
                    args = {
                        "run", -- Exécute le formateur dans l'environnement du projet.
                        "--no-sync", -- Évite que uv tente de synchroniser les dépendances à chaque formatage.
                        "isort",
                        "--filename",
                        "$FILENAME",
                        "-",
                    },
                    stdin = true, -- Transmet le contenu du buffer à formater sur l'entrée standard.
                    cwd = python_project_root, -- Définit la racine du projet à partir de uv.lock ou pyproject.toml.
                    require_cwd = true, -- Évite d'exécuter ces formateurs si aucune racine de projet n'est trouvée.
                    inherit = false, -- Empêche de reprendre les arguments du formateur intégré de Conform
                },

                black = {
                    command = "uv",
                    args = {
                        "run",
                        "--no-sync",
                        "black",
                        "--stdin-filename",
                        "$FILENAME",
                        "--quiet",
                        "-",
                    },
                    stdin = true,
                    cwd = python_project_root,
                    require_cwd = true,
                    inherit = false,
                },
            },
        },
    },
})

-- Use conform for gq.
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Start auto-formatting by default (and disable with my ToggleFormat command).
vim.g.autoformat = true
