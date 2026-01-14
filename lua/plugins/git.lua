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
                        -- fzf_lua = true,
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
