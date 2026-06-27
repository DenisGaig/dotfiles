local add_on_event = require("vim-pack").add_on_event

-- Better text objects.
add_on_event("BufReadPre", {
    {
        src = "nvim-treesitter/nvim-treesitter-textobjects",
        setup = false,
    },
    {
        src = "nvim-mini/mini.ai",
        opts = function()
            local miniai = require "mini.ai"

            return {
                n_lines = 100,
                -- todo: add more custom entries?
                custom_textobjects = {
                    f = miniai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                },
                -- disable error feedback.
                silent = true,
                search_method = "cover_or_next",
                -- don't use the previous or next text object.
                -- search_method = 'cover',
                mappings = {
                    -- disable next/last variants.(config MariaSol)
                    -- around_next = "",
                    -- inside_next = "",
                    -- around_last = "",
                    -- inside_last = "",
                    around_next = "an",
                    inside_next = "in",
                    around_last = "al",
                    inside_last = "il",
                },
            }
        end,
    },
})
