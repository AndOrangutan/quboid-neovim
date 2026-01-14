
vim.pack.add({
    {
        src = 'https://github.com/NeogitOrg/neogit',
        --@type lz.n.pack.Spec
        data = {
            cmd = 'Neogit',
            before = function ()
                ---@overload fun(plugin: lz.n.Plugin | lz.n.Plugin[])
                ---@overload fun(plugin_name: string | string[], opts: lz.n.lookup.Opts): string[]
                require('lz.n').trigger_load({
                    'plenary.nvim',
                })
            end,
            after = function ()
                require('neogit').config({
                    integrations = {
                        -- diffview = true,
                        -- fzf_lua = true,
                    },
                    graph_style = 'unicode',
                })
            end,
            keys = {
                { '<leader>gg', '<CMD>Neogit<CR>', desc = '[g]it [g]ui (neogit)' },
            },
        },
    },
})
