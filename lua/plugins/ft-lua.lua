---@module 'lze'
---@type lze.Spec[]
return {
    {
        src = 'https://github.com/folke/lazydev.nvim',
        data = {
            ft = 'lua',
            dep_of = {
                'blink.cmp',
            },
            lazy = true,
            after = function ()
                require('lazydev').setup({
                    library = {
                        -- Library paths can be absolute
                        -- '~/projects/my-awesome-lib',
                        -- Or relative, which means they will be resolved from the plugin dir.
                        'lze',
                        -- It can also be a table with trigger words / mods
                        -- Only load luvit types when the `vim.uv` word is found
                        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                        -- Load the wezterm types when the `wezterm` module is required
                        -- Needs `DrKJeff16/wezterm-types` to be installed
                        { path = 'wezterm-types', mods = { 'wezterm', 'config' } },
                        -- Load the xmake types when opening file named `xmake.lua`
                        -- Needs `LelouchHe/xmake-luals-addon` to be installed
                        -- { path = 'xmake-luals-addon/library', files = { 'xmake.lua' } },

                        -- Awesome
                        { path = '/usr/share/awesome/lib', words = { 'awesome', 'awful' } },
                    },
                    -- disable when a .luarc.json file is found
                    enabled = function(root_dir)
                        return not vim.uv.fs_stat(root_dir .. '/.luarc.json')
                    end,
                })
            end
        },
    },
    {
        src = 'https://github.com/DrKJeff16/wezterm-types',
        data = {
            lazy = true,
            dep_of = {
                'lazydev.nvim',
            },
        },
    },
}
