---@type lz.n.pack.Spec[]

vim.pack.add({
    {
        src = 'https://github.com/navarasu/onedark.nvim',
        data = {
            colorshceme = 'onedark',
            -- after = function ()
            --     require('onedark').setup({
            --         code_style = {
            --             comments = 'italic',
            --             keywords = 'italic,bold',
            --             functions = 'bold',
            --             strings = 'italic',
            --             variables = 'none'
            --         },
            --         lualine = {
            --             transparent = false, -- lualine center bar transparency
            --         },
            --         diagnostics = {
            --             undercurl = false,
            --         }
            --     })
            -- end,
        },
    }
})
