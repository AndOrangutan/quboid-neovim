return {
    {
        src = 'https://github.com/dstein64/vim-startuptime',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            cmd = "StartupTime",
            before = function ()
                -- vim.cmd[[vim.g.startuptime.tries = 10]]
            end,
        },
    },
}
