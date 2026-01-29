local _M = {}

----------------
-- Exclusions --
----------------


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

_M.ft_support = {
    'lock',
    'lua',
    'markdown',
    'nix',
}

-- TODO: move to supporter
_M.bt_exclude = {
    'nofile',
    'quickfix',
    'prompt',
}
return _M
