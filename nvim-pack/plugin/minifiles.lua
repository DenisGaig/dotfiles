-- lua/plugins/minifiles.lua
local add = require("vim-pack").add

local function map_split(buf_id, lhs, direction)
    local minifiles = require "mini.files"
    local function rhs()
        local window = minifiles.get_explorer_state().target_window
        if window == nil or minifiles.get_fs_entry().fs_type == "directory" then
            return
        end
        local new_target_window
        vim.api.nvim_win_call(window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
        end)
        minifiles.set_target_window(new_target_window)
        minifiles.go_in { close_on_file = true }
    end
    vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. string.sub(direction, 12) })
end

add {
    {
        src = "nvim-mini/mini.files",
        --module_name = 'mini.files',
        opts = {
            mappings = {
                show_help = "?",
                go_in_plus = "<cr>",
                go_out_plus = "<tab>",
            },
            windows = {
                preview = true,
                width_focus = 30,
                width_preview = 30,
                width_nofocus = 25,
            },
            options = {
                permanent_delete = false,
                use_as_default_explorer = false,
            },
            content = {
                filter = function(entry)
                    return entry.fs_type ~= "file" or entry.name ~= ".DS_Store"
                end,
                sort = function(entries)
                    local function compare_alphanumerically(e1, e2)
                        if e1.is_dir and not e2.is_dir then
                            return true
                        end
                        if not e1.is_dir and e2.is_dir then
                            return false
                        end
                        if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
                            return e1.digits < e2.digits
                        end
                        return e1.lower_name < e2.lower_name
                    end
                    local sorted = vim.tbl_map(function(entry)
                        local pre_digits, digits = entry.name:match "^(%D*)(%d+)"
                        if digits ~= nil then
                            digits = tonumber(digits)
                        end
                        return {
                            fs_type = entry.fs_type,
                            name = entry.name,
                            path = entry.path,
                            lower_name = entry.name:lower(),
                            is_dir = entry.fs_type == "directory",
                            pre_digits = pre_digits,
                            digits = digits,
                        }
                    end, entries)
                    table.sort(sorted, compare_alphanumerically)
                    return vim.tbl_map(function(x)
                        return { name = x.name, fs_type = x.fs_type, path = x.path }
                    end, sorted)
                end,
            },
        },
        on_setup = function()
            -- LSP rename/move handler (de ton ancienne config)
            vim.api.nvim_create_autocmd("User", {
                desc = "Notify LSPs that a file was renamed",
                pattern = { "MiniFilesActionRename", "MiniFilesActionMove" },
                callback = function(args)
                    local changes = {
                        files = {
                            {
                                oldUri = vim.uri_from_fname(args.data.from),
                                newUri = vim.uri_from_fname(args.data.to),
                            },
                        },
                    }
                    local will_rename = "workspace/willRenameFiles"
                    local did_rename = "workspace/didRenameFiles"
                    for _, client in ipairs(vim.lsp.get_clients()) do
                        if client:supports_method(will_rename) then
                            local res = client:request_sync(will_rename, changes, 1000, 0)
                            if res and res.result then
                                vim.lsp.util.apply_workspace_edit(res.result, client.offset_encoding)
                            end
                        end
                    end
                    for _, client in ipairs(vim.lsp.get_clients()) do
                        if client:supports_method(did_rename) then
                            client:notify(did_rename, changes)
                        end
                    end
                end,
            })

            -- Splits dans minifiles (de Maria)
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    map_split(buf_id, "<C-w>s", "belowright horizontal")
                    map_split(buf_id, "<C-w>v", "belowright vertical")
                end,
            })

            -- Keymap d'ouverture — tu utilisais <leader>fm, Maria utilisait <leader>e
            vim.keymap.set("n", "<leader>fm", function()
                local bufname = vim.api.nvim_buf_get_name(0)
                local path = vim.fn.fnamemodify(bufname, ":p")
                if path and vim.uv.fs_stat(path) then
                    require("mini.files").open(bufname, false)
                end
            end, { desc = "File explorer" })
        end,
    },
}
