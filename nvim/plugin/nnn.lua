local add = require("vim-pack").add

add {
    {
        src = "mcchrish/nnn.vim",
        module_name = "nnn",
        opts = {
            action = {
                ["<c-t>"] = "tab split",
                ["<c-s>"] = "split",
                ["<c-v>"] = "vsplit",
            },
        },
    },
}
