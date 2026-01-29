local sup = require('supporter')
return {
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
