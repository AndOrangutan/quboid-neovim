return {
    {
        src = 'https://github.com/nvim-mini/mini.icons',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            dep_of = {
                'blink.cmp',
                'diffview.nvim',
                'fzf-lua',
                'lspconfig',
            },
            after = function ()
                require('mini.icons').setup()
                MiniIcons.mock_nvim_web_devicons()
            end,
        },
    },
    {
        src = 'https://github.com/nvim-lua/plenary.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            dep_of = {
                'neogit',
            },
        },
    },
}
