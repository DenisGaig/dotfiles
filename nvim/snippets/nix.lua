local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

return {

    -- let ... in
    -- s("let", {
    --     t "let\n  ",
    --     i(1),
    --     t "\nin\n  ",
    --     i(0),
    -- }),
    --
    -- if then else
    -- s("if", {
    --     t "if ",
    --     i(1, "condition"),
    --     t " then\n  ",
    --     i(2),
    --     t "\nelse\n  ",
    --     i(0),
    -- }),

    -- with pkgs;
    s("with", {
        t "with ",
        i(1, "pkgs"),
        t ";",
    }),

    -- inherit
    s("inh", {
        t "inherit ",
        i(1),
        t ";",
    }),

    -- lib.mkIf
    s("mkif", {
        t "lib.mkIf ",
        i(1, "cfg.enable"),
        t " {\n  ",
        i(0),
        t "\n}",
    }),

    -- mkEnableOption
    s("enable", {
        t 'lib.mkEnableOption "',
        i(1),
        t '"',
    }),

    -- mkOption
    s("option", {
        t {
            "lib.mkOption {",
            "  type = lib.types.",
        },
        i(1, "bool"),
        t { ";", "  default = " },
        i(2, "false"),
        t { ";", '  description = "' },
        i(3),
        t { '";', "}" },
    }),

    -- options.xxx
    s("opts", {
        t "options.",
        i(1, "userSettings"),
        t ".",
        i(2),
        t " = {",
        t { "", "  " },
        i(0),
        t { "", "};" },
    }),

    -- config = lib.mkIf ...
    s("config", {
        t "config = lib.mkIf ",
        i(1, "cfg.enable"),
        t " {\n  ",
        i(0),
        t "\n};",
    }),

    -- home.packages
    s("packages", {
        t {
            "home.packages = with pkgs; [",
            "  ",
        },
        i(1),
        t {
            "",
            "];",
        },
    }),

    -- systemPackages
    s("system", {
        t {
            "environment.systemPackages = with pkgs; [",
            "  ",
        },
        i(1),
        t {
            "",
            "];",
        },
    }),

    -- systemd service
    s("service", {
        t {
            'systemd.user.services."',
        },
        i(1, "name"),
        t {
            [[" = {]],
            "  Unit = {",
            '    Description = "',
        },
        i(2),
        t {
            '";',
            "  };",
            "",
            "  Service = {",
            '    ExecStart = "',
        },
        i(3),
        t {
            '";',
            "  };",
            "};",
        },
    }),
}
