local sup = require('supporter')
sup.insert('ft-exclude', {
    { 'oil', {
        'oil'
    } }
})

return {
    {
        src = 'https://github.com/stevearc/oil.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            dep_of = {
                'oil-git-status.nvim',
                'oil-lsp-diagnostics.nvim',
            },
            after = function ()
                function _G.get_oil_winbar()
                    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
                    local dir = require('oil').get_current_dir(bufnr)
                    if dir then
                        return vim.fn.fnamemodify(dir, ':~')
                    else
                        -- If there is no current directory (e.g. over ssh), just show the buffer name
                        return vim.api.nvim_buf_get_name(0)
                    end
                end
                require('oil').setup({
                    keymaps = {
                        ['g?'] = { 'actions.show_help', mode = 'n' },
                        ['<CR>'] = 'actions.select',
                        ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
                        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
                        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
                        ['<C-p>'] = 'actions.preview',
                        ['<ESC>'] = { 'actions.close', mode = 'n' },
                        ['<C-c>'] = { 'actions.close', mode = 'n' },
                        ['<C-l>'] = 'actions.refresh',
                        ['-'] = { 'actions.parent', mode = 'n' },
                        ['_'] = { 'actions.open_cwd', mode = 'n' },
                        ['`'] = { 'actions.cd', mode = 'n' },
                        ['g~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
                        ['gs'] = { 'actions.change_sort', mode = 'n' },
                        ['gx'] = 'actions.open_external',
                        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
                        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
                    },
                    win_options = {
                        winbar = '%!v:lua.get_oil_winbar()',
                        -- signcolumn = 'yes',
                    },
                })
                vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory (Oil)' })
            end,
        },
        cmd = 'Oil',
        keys = {
        },
    },
    {
        src = 'https://github.com/malewicz1337/oil-git.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            after = function ()
                -- local icons = require('icons')

                require('oil-git').setup({
                    show_file_symbols = false,
                    show_file_highlights = true,
                    show_directory_highlights = false,
                    show_ignored_files = true,
                    symbol_position = 'signcolumn',
                    can_use_signcolmn = true,
                    show_directory_symbols = false
                })
            end,
        },
    },
    {
        src = 'https://github.com/JezerM/oil-lsp-diagnostics.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            after = function ()
                -- local icons = require('icons')

                require('oil-lsp-diagnostics').setup({
                })
            end,
        },
    },
}
