-- Install with: npm install -g @astrojs/language-server
---@type vim.lsp.Config
return {
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
    init_options = {
        typescript = {
            -- tsdk = vim.fn.expand "/node_modules/typescript/lib",
            tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
        },
    },
}
