local defaults = require('defaults')

local highlights = vim.api.nvim_create_augroup('highlights', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    group = highlights,
    callback = function()
        -- Rebind float
        vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })

        -- Requires `vim.opt.cursorline = true`
        vim.api.nvim_set_hl(0, 'CursorLine', { link = 'NONE' })

        -- vim.api.nvim_set_hl(0, 'WinBar', { link = 'Normal' })
        -- vim.api.nvim_set_hl(0, 'WinBarNC', { link = 'Normal' })

        vim.api.nvim_set_hl(0, 'BlinkCmpSource', { link = 'Comment' })

        vim.api.nvim_set_hl(0, 'OilGitAdded',     { link = 'GitSignsAdd' })
        vim.api.nvim_set_hl(0, 'OilGitModified',  { link = 'GitSignsChange' })
        vim.api.nvim_set_hl(0, 'OilGitDeleted',   { link = 'GitSignsDelete' })
        vim.api.nvim_set_hl(0, 'OilGitRenamed',   { link = 'GitSignsChange' })
        vim.api.nvim_set_hl(0, 'OilGitCopied',    { link = 'GitSignsAdd' })
        vim.api.nvim_set_hl(0, 'OilGitConflict',  { link = 'DiagnosticError' })
        vim.api.nvim_set_hl(0, 'OilGitUntracked', { link = 'DiagnosticHint' })
        vim.api.nvim_set_hl(0, 'OilGitIgnored',   { link = 'Comment' })

    end,
})

vim.opt.background = defaults.background

local ok, err = pcall(vim.cmd, 'colorscheme ' .. defaults.colorscheme)
if not ok then
    vim.cmd('colorscheme default')
    vim.notify('Unable to load colorscheme: '..err, vim.log.levels.WARN)
end
