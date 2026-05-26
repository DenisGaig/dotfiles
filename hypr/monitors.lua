---@diagnostic disable: undefined-global
-- =============================================================================
-- monitors.lua
-- =============================================================================

hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@60", position = "0x0", scale = 1.0 })
hl.monitor({ output = "eDP-1", mode = "1366x768@60", position = "1920x0", scale = 1.0 })

-- Workspaces
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1" })
