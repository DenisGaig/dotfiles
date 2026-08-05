-- lsp/nixd.lua

---@type vim.lsp.Config
return {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "alejandra" }, -- ou alejandra, selon ce que tu utilises
            },
            options = {
                nixos = {
                    expr = '(builtins.getFlake "/home/denis/nixos-config/").nixosConfigurations.denislab.options',
                },
                home_manager = {
                    expr = '(builtins.getFlake "/home/denis/nixos-config/").homeConfigurations.denis.options',
                },
            },
        },
    },
}
