-- lsp/markdown_oxide.lua
return {
    cmd = { "markdown-oxide" },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
}
