local add = require('vim-pack').add

-- Better copy/pasting.
add {
    {
        src = 'gbprod/yanky.nvim',
        opts = {
            ring = { history_length = 20 },
            highlight = { timer = 250 },
        },
        on_setup = function()
            local pick  = require('mini.pick')
            vim.keymap.set({ 'n', 'x' }, '<leader>sy', function()
            local history = require('yanky.history').all()
            if vim.tbl_isempty(history) then
                vim.notify('Yank history is empty', vim.log.levels.INFO)
                return
            end

            -- Strings simples + lookup pour retrouver l'entry
            local lookup = {}
            local items  = {}
            for _, entry in ipairs(history) do
                local text = entry.regcontents
                if not lookup[text] then
                    lookup[text] = entry
                    table.insert(items, text)
                end
            end

            require('mini.pick').start({
                source = {
                    name   = 'Yank History',
                    items  = items,
                    choose = function(item)
                        local entry = lookup[item]
                        if not entry then return end
                        vim.schedule(function()
                            -- Registre 'z' pour éviter toute interférence avec yanky
                            vim.fn.setreg('z', entry.regcontents, entry.regtype or 'v')
                            vim.cmd('normal! "zp')
                        end)
                    end,
                },
            })
            end, { desc = 'Open Yank History' })
            vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Put yanked text after cursor' })
            vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Put yanked text before cursor' })
            vim.keymap.set('n', '=p', '<Plug>(YankyPutAfterLinewise)', { desc = 'Put yanked text in line below' })
            vim.keymap.set('n', '=P', '<Plug>(YankyPutBeforeLinewise)', { desc = 'Put yanked text in line above' })
            vim.keymap.set('n', '[y', '<Plug>(YankyCycleForward)', { desc = 'Cycle forward through yank history' })
            vim.keymap.set('n', ']y', '<Plug>(YankyCycleBackward)', { desc = 'Cycle backward through yank history' })
            vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)', { desc = 'Yanky yank' })
        end,
    },
}

