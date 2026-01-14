return {
    {
        src = 'https://github.com/ibhagwan/fzf-lua',
        ---@type lze.pack.Spec[]
        data = {
            after = function()
                ---@module "fzf-lua"
                ---@type fzf-lua.Config|{}
                ---@diagnostic disable: missing-fields
                require('fzf-lua').setup({
                    defaults = {
                        file_icons = 'mini',
                        file_icon_padding = ' ',
                    },
                    hls = {
                        normal = 'NormalFloat',
                        border = 'NormalFloat',
                        title = 'NormalFloat',
                        previewBorder = 'Normal',
                        previewNormal = 'Normal',
                        cursor = 'Normal',
                        cursorLine = 'Normal',
                    },
                    winopts = {
                        border = require('defaults').border,
                        preview = {
                            border = require('defaults').border,
                        },
                    }
                })
            end,
            keys = {
                { lhs = '<leader>pf', rhs = '<cmd>lua require("fzf-lua").files()<cr>', desc = '[p]icker [f]iles (fzf-lua)' },
                { lhs = '<leader>pg', rhs = '<cmd>lua require("fzf-lua").live_grep()<cr>', desc = '[p]icker [g]rep (fzf-lua)' },
                { lhs = '<leader>ph', rhs = '<cmd>lua require("fzf-lua").helptags()<cr>', desc = '[p]icker [h]elp (fzf-lua)' },
                { lhs = '<leader>pa', rhs = '<cmd>lua require("fzf-lua").builtin()<cr>', desc = '[p]icker All (fzf-lua)' },
            },
        }
    }
}
