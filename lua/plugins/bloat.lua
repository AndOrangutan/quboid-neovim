
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
                require('mini.animate').setup()
            end
        },
    },
}
