
return {
    {
        src = 'https://github.com/stevearc/overseer.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            dep_of = {
                -- 'auto-session',
            },
            after = function ()
                require('overseer').setup()
                -- TODO: add statusline inte
                -- TODO: add dap inte
                -- TODO: add neotest inte
                -- TODO: add sessions inte
            end,
        },
    },
}
