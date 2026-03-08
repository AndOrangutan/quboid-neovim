return {

    {
        src = 'https://github.com/folke/todo-comments.nvim',
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
            },
            lazy = true,
            cmd = {
            },
            after = function ()
                require('todo-comments').setup()
            end,
            keys = {
                { lhs = ']t', rhs = '<CMD>lua require("todo-comments").jump_next()<CR>', desc = 'Next [t]odo (todo-comments)' },
                { lhs = '[t', rhs = '<CMD>lua require("todo-comments").jump_prev()<CR>', desc = 'Previous [t]odo (todo-comments)' },
                { lhs = '<leader>pt', rhs = '<CMD>TodoFzfLua<CR>', desc = '[p]icker [t]odo (todo-comments)' },
            },
        },
    },
    {
        src = 'https://github.com/folke/trouble.nvim',
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
                'todo-comments.nvim',
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
