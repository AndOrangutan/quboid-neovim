local _M = {}

----------------
-- Exclusions --
----------------

_M.ft_exclude = {
    '', -- disable for empty buffer
    'fugitive',
    'NeogitCommitMessage',
    'NeogitDiffView',
    'NeogitStatus',
}

_M.bt_exclude = {
    'nofile',
    'quickfix',
    'prompt',
}

---------
-- GUI --
---------
_M.background = "dark"
_M.border = {
    {" ", "FloatBorder"},
    {" ", "FloatBorder"},
    {" ", "FloatBorder"},
    {" ", "FloatBorder"},
    {" ", "FloatBorder"},
    {" ", "FloatBorder"},
    {" ", "FloatBorder"},
    {" ", "FloatBorder"},
}
_M.colorscheme = "onedark"

return _M
