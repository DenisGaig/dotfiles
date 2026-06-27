-- Install with
-- mac: brew install llvm
-- Arch: pacman -S clang

---@type vim.lsp.Config
return {
    cmd = {
        "clangd",
        "--clang-tidy", -- active les diagnostics statiques (style, bugs potentiels)
        "--header-insertion=iwyu",
        "--completion-style=detailed", --affiche les signatures complètes dans la complétion
        "--fallback-style=none",
        "--function-arg-placeholders=false", -- désactive l'insertion de placeholders lors de la complétion d'une fonction
    },
    filetypes = { "c", "cpp" },
    root_markers = { ".clangd", "compile_flags.txt", "compile_commands.json", ".git" },
}
