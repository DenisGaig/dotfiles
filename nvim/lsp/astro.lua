-- Install with: npm install -g @astrojs/language-server
---@type vim.lsp.Config
return {
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
    init_options = {
        typescript = {
            tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
            -- tsdk = "",
        },
    },
    -- on_init = function(client)
    --     local tsdk = client.config.root_dir .. "/node_modules/typescript/lib"
    --     client.config.init_options.typescript.tsdk = tsdk
    --     client:notify("workspace/didChangeConfiguration", { settings = {} })
    -- end,
}
