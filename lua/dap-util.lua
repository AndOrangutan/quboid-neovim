local _M = {}

_M.path_to_executable = function (exec)
    local path_base = (exec and exec ~= '') and exec or vim.fn.getcwd() .. '/'

    local path_input = vim.fn.input({
        prompt = 'Path to executable: ',
        default = path_base,
        completion = 'file',
    })
    vim.cmd('redraw')

    if path_input == '' or path_input == path_base or path_input == nil then
        vim.notify('DAP: Invalid executable input', vim.log.levels.WARN)
        return nil
    end

    local path_full = vim.fn.expand(path_input)

    if vim.fn.executable(path_full) == 0 then
        vim.notify('DAP: Provided file isn\'t executable', vim.log.levels.WARN)
        return nil
    end
    return path_input
end

return _M
