local _M = {}

_M.did_init = false

_M.init = function()
    if did_init then
        return
    else
        require('config.autocmds')
        require('config.keybinds')
        require('config.options')
    end

    _M.did_init = true
end

return _M
