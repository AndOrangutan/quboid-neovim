return {
    {
        src = 'https://github.com/nvim-mini/mini.jump',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
            after = function ()
                require('mini.jump').setup({
                    delay = {
                        -- Delay between jump and highlighting all possible jumps
                        highlight = 0,

                        -- Delay between jump and automatic stop if idle (no jump is done)
                        idle_stop = 1500,
                    },
                })
            end
        },
    },
}
