local sup = require('supporter')

sup.insert('ft-exclude', {
    { 'neogit', { 'NeogitCommitMessage', 'NeogitDiffView', 'NeogitStatus' } }
})

return {
    {
        src = 'https://github.com/sindrets/diffview.nvim',
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
                'neogit'
            },
            lazy = true,
            cmd = {
                'DiffviewOpen',
                'DiffviewClose',
                'DiffviewToggleFiles',
                'DiffviewFocusFiles',
                'DiffviewRefresh',
            },
        },
    },
    {
        src = 'https://github.com/lewis6991/gitsigns.nvim',
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
                -- TODO: add trouble
            },
            lazy = true,
            event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
            cmd = {
            },
            after = function ()
                local icons = require('icons')
                require('gitsigns').setup({
                    signs = {
                        add          = { text = icons.ui.bar_thick },
                        change       = { text = icons.ui.bar_thick },
                        delete       = { text = '_' },
                        topdelete    = { text = '‾' },
                        changedelete = { text = '~' },
                        untracked    = { text = icons.ui.bar_thick_split },
                    },
                    signs_staged = {
                        add          = { text = icons.ui.bar_thick },
                        change       = { text = icons.ui.bar_thick },
                        delete       = { text = '_' },
                        topdelete    = { text = '‾' },
                        changedelete = { text = '~' },
                        untracked    = { text = icons.ui.bar_thick_split },
                    },
                })
            end,
        },
    },
    {
        src = 'https://github.com/NeogitOrg/neogit',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            cmd = {
                'Neogit'
            },
            after = function ()
                require('neogit').setup({
                    integrations = {
                        diffview = true,
                        fzf_lua = true,
                    },
                    graph_style = 'unicode',
                })
            end,
            keys = {
                { lhs = '<leader>gg', rhs = '<CMD>Neogit<CR>', desc = '[g]it [g]UI (neogit)' },
            },
        },
    },
}
