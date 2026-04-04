-- local spaces = 4
vim.opt_local.shiftwidth    = 4 -- Shift 4 spaces when tabbing
vim.opt_local.tabstop       = 4 -- 1 tab = 4 spaces

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.showbreak = ' '
vim.opt_local.textwidth = 0
-- vim.opt_local.columns = 80
vim.opt_local.breakindent = true
vim.opt_local.conceallevel = 2
vim.opt_local.spell = true

vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { desc = 'Wrap [j]ump Down', buffer = true, expr = true, silent = true })
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { desc = 'Wrap [k]ick Up', buffer = true, expr = true, silent = true })
