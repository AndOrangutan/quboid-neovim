local sup = require('supporter')


return {

    {
        src = 'https://github.com/nvim-mini/mini.files',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            after = function ()
                require('mini.files').setup({
                    -- Customization of shown content
                    -- content = {
                    --     -- Predicate for which file system entries to show
                    --     filter = nil,
                    --     -- Highlight group to use for a file system entry
                    --     highlight = nil,
                    --     -- Prefix text and highlight to show to the left of file system entry
                    --     prefix = nil,
                    --     -- Order in which to show file system entries
                    --     sort = nil,
                    -- },

                    -- Module mappings created only inside explorer.
                    -- Use `''` (empty string) to not create one.
                    mappings = {
                        close       = 'q',
                        go_in       = 'l',
                        go_in_plus  = 'L',
                        go_out      = 'h',
                        go_out_plus = 'H',
                        mark_goto   = "'",
                        mark_set    = 'm',
                        reset       = '<BS>',
                        reveal_cwd  = '@',
                        show_help   = 'g?',
                        synchronize = '=',
                        trim_left   = '<',
                        trim_right  = '>',
                    },

                    -- General options
                    options = {
                        -- Whether to delete permanently or move into module-specific trash
                        permanent_delete = true,
                        -- Whether to use for editing directories
                        use_as_default_explorer = true,
                    },

                    -- Customization of explorer windows
                    windows = {
                        -- Maximum number of windows to show side by side
                        max_number = math.huge,
                        -- Whether to show preview of file/directory under cursor
                        preview = true,
                        -- Width of focused window
                        width_focus = 50,
                        -- Width of non-focused window
                        width_nofocus = 15,
                        -- Width of preview window
                        width_preview = 25,
                    },
                })
            end,
            keys = {
                { lhs = '-', rhs = '<CMD>lua MiniFiles.open()<CR>', desc = 'File Explorer (Mini)' },
            },
            event = { 'BufReadPost', 'BufNewFile' },
        },
    },
    {
        src = 'https://github.com/luukvbaal/statuscol.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            after = function ()
                local builtin = require('statuscol.builtin')

                vim.opt.foldcolumn = '0'
                vim.opt.signcolumn = 'yes'

                require('statuscol').setup({
                    thousands = true,
                    relculright = true,
                    setopt = true,
                    bt_ignore = sup.by('bt-exclude'),
                    ft_ignore = sup.by('ft-exclude'),
                    segments = {
                        { text = { builtin.lnumfunc }, click = 'v:lua.ScLa', },
                        {
                            sign = { namespace = { 'gitsigns' }, maxwidth = 1, colwidth = 1, auto = true },
                            click = 'v:lua.ScSa',
                        },
                        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
                        {
                            sign = { namespace = { 'diagnostic' }, maxwidth = 1, auto = false },
                            click = 'v:lua.ScSa'
                        },
                        {
                            sign = { name = { '.*' }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                            click = 'v:lua.ScSa'
                        },
                    }
                })
            end,
            event = { 'BufReadPost', 'BufNewFile' },
        },
    },
}
