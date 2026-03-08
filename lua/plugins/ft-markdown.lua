local deus_vault = vim.fn.expand('~')..'/Sync/Notes/compendium/'

return  {

    {
        src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim',
        -- version = vim.version.range('*'),
        --#module lze
        ---@type lze
        data = {
            ft = {
                'markdown',
            },
            lazy = true,
            cmd = {
            },
            after = function ()
                ---@module 'render-markdown'
                ---@type render.md.UserConfig
                require('render-markdown').setup({
                    link = { enabled = false },
                    heading = {
                        icons = {
                            '󰬺 '..' ',
                            '󰬻 '..' ',
                            '󰬼 '..' ',
                            '󰬽 '..' ',
                            '󰬾 '..' ',
                            '󰬿 '..' ',
                            '󰭀 '..' ',
                            '󰭁 '..' ',
                            '󰭂 '..' ',
                        },
                    },
                })
            end,
        },
    },
    {
        src = 'https://github.com/obsidian-nvim/obsidian.nvim',
        -- version = vim.version.range('*'),
        --#module lze
        ---@type lze
        data = {
            ft = {
                'markdown',
            },
            lazy = true,
            dep_of = {
            },
            cmd = {
                'Obsidian',
            },
            after = function ()
                ---@module 'obsidian'
                ---@type obsidian.config
                require('obsidian').setup({
                    legacy_commands = false,

                    completion = {
                        min_chars = 1,
                    },
                    new_note_location = 'current_dir',
                    note_id_func = function (title) return title end,
                    open = {
                        use_advanced_uri = true,
                        func = vim.ui.open,
                    },
                    templates = {
                        folder = 'templates',
                        date_format = "%Y-%m-%d",
                        time_format = "%H:%M",
                        -- A map for custom variables, the key should be the variable and the value a function.
                        -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
                        -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
                        substitutions = {},

                        -- A map for configuring unique directories and paths for specific templates
                        --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
                        customizations = {},
                    },
                    ui = {
                        enable = false,
                    },
                    workspaces = {
                        {
                            name = 'personal',
                            path = deus_vault,
                        },
                    },
                })
            end,
        },
    },
}
