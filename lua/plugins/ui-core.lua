local sup = require('supporter')


return {

    {
        src = 'https://github.com/Bekaboo/dropbar.nvim',
        ---@type lze.pack.Spec[]
        data = {
            -- TODO: integrate icons across plugins
            lazy = false,
            keys = {
                { lhs = '<leader>;', rhs = '<Cmd>lua require("dropbar.api").pick()<CR>' , desc = 'Pick Winbar (dropbar)' },
                { lhs = '[;', rhs = '<Cmd>lua require("dropbar.api").goto_context_start()<CR>' , desc = 'Goto Prev Winbar Context (dropbar)' },
                { lhs = '];', rhs = '<Cmd>lua require("dropbar.api").select_next_context()<CR>' , desc = 'Goto Next Winbar Context (dropbar)' },
            },
        },
    },
    {
        src = 'https://github.com/nvim-mini/mini.clue',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            after = function ()
                local miniclue = require('mini.clue')
                miniclue.setup({
                    triggers = {
                        -- Leader triggers
                        { mode = { 'n', 'x' }, keys = '<Leader>' },

                        -- `[` and `]` keys
                        { mode = 'n', keys = '[' },
                        { mode = 'n', keys = ']' },

                        -- Built-in completion
                        { mode = 'i', keys = '<C-x>' },

                        -- `g` key
                        { mode = { 'n', 'x' }, keys = 'g' },

                        -- Marks
                        { mode = { 'n', 'x' }, keys = "'" },
                        { mode = { 'n', 'x' }, keys = '`' },

                        -- Registers
                        { mode = { 'n', 'x' }, keys = '"' },
                        { mode = { 'i', 'c' }, keys = '<C-r>' },

                        -- Window commands
                        { mode = 'n', keys = '<C-w>' },

                        -- `z` key
                        { mode = { 'n', 'x' }, keys = 'z' },
                    },

                    clues = {
                        -- Enhance this by adding descriptions for <Leader> mapping groups
                        miniclue.gen_clues.square_brackets(),
                        miniclue.gen_clues.builtin_completion(),
                        miniclue.gen_clues.g(),
                        miniclue.gen_clues.marks(),
                        miniclue.gen_clues.registers(),
                        miniclue.gen_clues.windows(),
                        miniclue.gen_clues.z(),
                    },
                })
            end,
        },
    },
    {
        src = 'https://github.com/nvim-mini/mini.notify',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            after = function ()

                require('mini.notify').setup({
                    lsp_progress = { duration_last = 500 },
                    window = {
                        max_width_share = 0.5
                    },
                    content = {
                        -- Use notification message as is for LSP progress
                        format = function(notif)
                            if notif.data.source == 'lsp_progress' then return notif.msg end
                            return MiniNotify.default_format(notif)
                        end,

                        -- Show more recent notifications first
                        sort = function(notif_arr)
                            local res, present_msg = {}, {}
                            for _, notif in ipairs(notif_arr) do
                                if not present_msg[notif.msg] then
                                    table.insert(res, notif)
                                    present_msg[notif.msg] = true
                                end
                            end

                            table.sort(
                                res,
                                function(a, b) return a.ts_update > b.ts_update end
                            )
                            return res
                        end,
                    }
                })

                vim.api.nvim_create_user_command('Messages', function()
                    vim.cmd[[split]]
                    MiniNotify.show_history()
                end, { desc = 'Show notification history (mini.notify)' })

                local n_progress = 0
                local lsp_progress_plus = function() n_progress = n_progress + 1 end
                vim.api.nvim_create_autocmd('LspProgress', { pattern = 'begin', callback = lsp_progress_plus })

                local lsp_progress_minus = function()
                    vim.defer_fn(function() n_progress = n_progress - 1 end, MiniNotify.config.lsp_progress.duration_last + 1)
                end
                vim.api.nvim_create_autocmd('LspProgress', { pattern = 'end', callback = lsp_progress_minus })

                -- The use `n_progress > 0` as a flag to use "LSP window config"
            end,
        },
    },
    {
        src = 'https://github.com/nvim-mini/mini.statusline',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            after = function ()
                require('mini.statusline').setup({
                    -- -- Content of statusline as functions which return statusline string. See
                    -- -- `:h statusline` and code of default contents (used instead of `nil`).
                    -- content = {
                    --     -- Content for active window
                    --     active = nil,
                    --     -- Content for inactive window(s)
                    --     inactive = nil,
                    -- },
                })
            end,
        },
    },
    {
        src = 'https://github.com/luukvbaal/statuscol.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            after = function ()
                local builtin = require('statuscol.builtin')

                vim.opt.foldcolumn = '0'
                vim.opt.signcolumn = 'yes'

                require('statuscol').setup({
                    thousands = true,
                    relculright = true,
                    setopt = true,
                    bt_ignore = sup.by('bt-exclude'),
                    ft_ignore = sup.by('ft-exclude'),
                    segments = {
                        { text = { builtin.lnumfunc }, click = 'v:lua.ScLa', },
                        {
                            sign = { namespace = { 'gitsigns' }, maxwidth = 1, colwidth = 1, auto = true },
                            click = 'v:lua.ScSa',
                        },
                        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
                        {
                            sign = { namespace = { 'diagnostic' }, maxwidth = 1, auto = false },
                            click = 'v:lua.ScSa'
                        },
                        {
                            sign = { name = { '.*' }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                            click = 'v:lua.ScSa'
                        },
                    }
                })
            end,
            event = { 'BufReadPost', 'BufNewFile' },
        },
    },
}
