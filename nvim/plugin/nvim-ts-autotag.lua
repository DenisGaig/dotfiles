local add_on_event = require("vim-pack").add_on_event

-- Autoclosing tags for HTML,JSX, ASTRO ...
add_on_event("InsertEnter", {
    {
        src = "windwp/nvim-ts-autotag",
        opts = {
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = false,
            },
        },
    },
})
