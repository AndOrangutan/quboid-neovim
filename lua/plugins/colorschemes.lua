return {
    src = 'https://github.com/navarasu/onedark.nvim',
    ---@type lze.pack.Spec[]
    data = {
        colorschme = {
            'onedark',
        },
        after = function()
            require('onedark').config({
                code_style = {
                    comments = 'italic',
                    keywords = 'italic,bold',
                    functions = 'bold',
                    strings = 'italic',
                    variables = 'none'
                },
                lualine = {
                    transparent = false, -- lualine center bar transparency
                },
                diagnostics = {
                    undercurl = false,
                },
            })
        end,
    }
}
