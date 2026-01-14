return {
    {
        src = 'https://github.com/dstein64/vim-startuptime',
        ---@type lze.pack.Spec[]
        data = {
            cmd = "StartupTime",
            before = function ()
                vim.g.startuptime.tries = 10
            end,
        },
    },
}
