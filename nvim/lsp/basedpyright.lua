-- Install with
-- Arch (AUR): paru -S basedpyright-bin
-- ou: pip install basedpyright

---@type vim.lsp.Config
return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
}
