local sup = require('supporter')

local ts_support = {
    'asm',
    'c',
    'cmake',
    'cpp',
    'disassembly',
    'doxygen',
    'html',
    'java',
    'latex',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'matlab',
    'nix',
    'objdump',
    'python',
    'vimdoc',
    'yaml',
    'zsh',
}

-- https://github.com/xzbdmw/colorful-menu.nvim
sup.insert('ft-plugin', {
    { 'treesitter', ts_support }
})

return {
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        name = 'nvim-treesitter',
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
                'blink.cmp',
                'otter.nvim',
                'render-markdown.nvim',
                'trouble.nvim',
            },
            lazy = false,
            run = function ()
                pcall(vim.cmd, 'TSUpdate')
            end,
            cmd = {
                'TSUpdate',
            },
            after = function ()
                require('nvim-treesitter').install(ts_support)

                vim.api.nvim_create_autocmd('FileType', {
                    pattern = ts_support,
                    callback = function()
                        vim.treesitter.start()
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        vim.wo[0][0].foldmethod = 'expr'
                    end,
                })
            end,
        },
    },
}
