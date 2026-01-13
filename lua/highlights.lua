local defaults = require('defaults')

local highlights = vim.api.nvim_create_augroup('highlights', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    group = highlights,
    callback = function()
        -- Rebind float
        vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })

        -- Requires `vim.opt.cursorline = true`
        vim.api.nvim_set_hl(0, "CursorLine", { link = "NONE" })

        -- vim.api.nvim_set_hl(0, 'WinBar', { link = "Normal" })
        -- vim.api.nvim_set_hl(0, 'WinBarNC', { link = "Normal" })
    end,
})

vim.opt.background = defaults.background

ok, err = pcall(vim.cmd, 'colorscheme ' .. defaults.colorscheme)
if not ok then
    vim.cmd('colorscheme default')
    vim.notify('Unable to load colorscheme: '..err, vim.log.levels.WARN)
end
