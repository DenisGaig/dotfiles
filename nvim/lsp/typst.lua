-- Install with
-- Arch: pacman -S tinymist

---@type vim.lsp.Config
return {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    root_markers = { ".git" },
}
