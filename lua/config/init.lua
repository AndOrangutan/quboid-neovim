local _M = {}

_M.did_init = false

_M.init = function()
    if did_init then
        return
    else
        -- Ranked by priority
        require('config.options')
        require('config.keybinds')
        require('config.autocmds')
    end

    _M.did_init = true
end

return _M
