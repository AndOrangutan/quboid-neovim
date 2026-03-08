local sup = require('supporter')

local ts_support = {
    'asm',
    'c',
    'cmake',
    'cpp',
    'disassembly',
    'doxygen',
    'html',
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
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
                'trouble.nvim',
                'render-markdown.nvim',
            },
            lazy = false,
            run = function ()
                vim.cmd[[TSUpdate]]
            end,
            cmd = {
                'TSUpdate',
            },
            after = function ()
                require('nvim-treesitter').install(ts_support)

                vim.api.nvim_create_autocmd('FileType', {
                    pattern = ts_support,
                    callback = function() vim.treesitter.start() end,
                })
            end,
        },
    },
}
