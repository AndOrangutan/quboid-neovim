return {
    {
        src = 'https://github.com/nvim-mini/mini.animate',
        ---@type lze.pack.Spec[]
        data = {
            event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
            dep_of = {
            },
            lazy = true,
            after = function ()
                require('mini.animate').setup({
                    scroll = {
                        timing = function(_, n) return math.min(250 / n, 5) end,
                    }
                })
            end,
            keys = {
                { lhs = 'n', rhs = '<Cmd>lua vim.cmd("normal! n"); ' .. 'MiniAnimate.execute_after("scroll", "normal! zvzz")<CR>' , desc = 'Smooth Center [n]ext' },
                { lhs = 'N', rhs = '<Cmd>lua vim.cmd("normal! N"); ' .. 'MiniAnimate.execute_after("scroll", "normal! zvzz")<CR>' , desc = 'Smooth Center Prev' },
                { lhs = '<C-u>', rhs = '<Cmd>lua vim.cmd("normal! <C-u>"); ' .. 'MiniAnimate.execute_after("scroll", "normal! zvzz")<CR>' , desc = 'Smooth Center Scroll Up' },
                { lhs = '<C-d>', rhs = '<Cmd>lua vim.cmd("normal! <C-d>"); ' .. 'MiniAnimate.execute_after("scroll", "normal! zvzz")<CR>' , desc = 'Smooth Center Scroll Down' },
            },
        },
    },
}
