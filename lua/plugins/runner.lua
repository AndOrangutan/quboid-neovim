return {
    {
        src = 'https://github.com/stevearc/overseer.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            dep_of = {
                -- 'auto-session',
            },
            after = function()
                require('overseer').setup()
                -- TODO: add statusline inte
                -- TODO: add dap inte
                -- TODO: add neotest inte
                -- TODO: add sessions inte
            end,
        },
    },

    {
        src = 'https://github.com/michaelb/sniprun',
        name = 'sniprun',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            cmd = {
                'SnipRun',
                'SnipInfo',
            },
            run = function(data)
                vim.schedule(function()
                    vim.notify('Building SnipRun...', vim.log.levels.INFO)
                end)

                -- Use the Nix command which is safer on NixOS
                -- 'data.path' is provided by the PackChanged event
                local obj = vim.system({ 'sh', './install.sh', '1' }, { cwd = data.path }):wait()
                -- local obj = vim.system({'cargo build --release' }, { cwd = data.path }):wait()


                vim.schedule(function()
                    if obj.code == 0 then
                        vim.notify('SnipRun built successfully!', vim.log.levels.INFO)
                    else
                        vim.notify('SnipRun build failed!', vim.log.levels.ERROR)
                        print(obj.stderr) -- Check :messages for errors
                    end
                end)
            end,
            after = function()
                require('sniprun').setup({
                    display = { 'Api' },
                    display_options = {
                        notification_timeout = 5,       -- in seconds
                        notification_render = "default" -- nvim-notify render style
                    },
                })

                local sa = require('sniprun.api')

                sa.register_listener(function(d)
                    if d.status == 'ok' then
                        vim.notify(d.message, vim.log.levels.INFO)
                    elseif d.status == 'error' then
                        vim.notify(d.message, vim.log.levels.WARN)
                    else
                        vim.notify(d.message)
                    end


                end)

            end,
        },
    },
}
