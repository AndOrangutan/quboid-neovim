return {
    {
        src = 'https://github.com/folke/trouble.nvim',
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
            },
            lazy = true,
            cmd = {
                'Trouble',
            },
            after = function ()
                require('trouble').setup()

                -- -- FZF lua integration
                -- local config = require('fzf-lua.config')
                -- local actions = require('trouble.sources.fzf').actions
                -- config.defaults.action.files['ctrl-t'] = actions.open
            end,
            keys = {
                { lhs = '<leader>xx', rhs = '<CMD>Trouble diagnostics toggle<CR>', desc = '[x]plore Diagnosti[x] (Trouble)' },
                { lhs = '<leader>xX', rhs = '<CMD>Trouble diagnostics toggle filter.buf=0<CR>', desc = '[x]plore Buffer Diagnosti[x] (Trouble)' },
                { lhs = '<leader>xs', rhs = '<CMD>Trouble diagnostics toggle focus=false<CR>', desc = '[x]plore [s]ymbolds (Trouble)' },
                { lhs = '<leader>xL', rhs = '<CMD>Trouble lsp toggle focus=false win.position=right<CR>', desc = '[x]plore [L]SP Defs and Refs (Trouble)' },
                { lhs = '<leader>xl', rhs = '<CMD>Trouble loclist toggle<CR>', desc = '[x]plore [l]ocation List (Trouble)' },
                { lhs = '<leader>xq', rhs = '<CMD>Trouble qflist toggle<CR>', desc = '[x]plore [q]uickfix List (Trouble)' },
            },
        },
    },
}
