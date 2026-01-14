return {
    src = 'https://github.com/NeogitOrg/neogit',
    ---@type lze.pack.Spec[]
    data = {
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
}
