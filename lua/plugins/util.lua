return {
    {
        src = 'https://github.com/jake-stewart/auto-cmdheight.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            after = function ()
                require('auto-cmdheight').setup()
            end,
        },
    },
    {
        src = 'https://github.com/rmagatti/auto-session',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            after = function ()
                require('auto-session').setup({
                    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
                    pre_save_cmds = {
                        function()
                            local tasks = require("overseer.task_list").list_tasks()
                            local cmds = {}
                            for _, task in ipairs(tasks) do
                                local json = vim.json.encode(task:serialize())
                                -- For some reason, vim.json.encode encodes / as \/.
                                json = string.gsub(json, "\\/", "/")
                                -- Escape single quotes so we can put this inside single quotes
                                json = string.gsub(json, "'", "\\'")
                                table.insert(cmds, string.format("lua require('overseer').new_task(vim.json.decode('%s')):start()", json))
                            end
                            return cmds
                        end,
                    },
                    -- Optionally get rid of all previous tasks when restoring a session
                    pre_restore_cmds = {
                        function()
                            for _, task in ipairs(require("overseer").list_tasks({})) do
                                task:dispose(true)
                            end
                        end,
                    },
                })
            end,
        },
    },
    {
        src = 'https://github.com/dstein64/vim-startuptime',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            cmd = 'StartupTime',
            before = function ()
                -- vim.cmd[[vim.g.startuptime.tries = 10]]
            end,
        },
    },
}
