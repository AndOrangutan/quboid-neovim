local _M = {}

--@alias Mode
local modes = {
    "bare",
    "minimal",
    "bloat",
}

---@type Mode[]
_M.current_modes = modes

-- Ordered list of modes
---@type table<lua_module, Mode[]>
_M.spec_modes = {
    [ "plugins.deps" ] = modes,

    [ "plugins.colorschemes" ] = modes,
    [ "plugins.git" ] = modes,
}

--@return lua_module[]
_M.gather_specs = function ()
    local lookup_modes = {}
    for _, m in ipairs(_M.current_modes) do
        lookup_modes[m] = true
    end

    local modules = {}

    for module, required_modes in pairs(_M.spec_modes) do
        for _, mode in ipairs(required_modes) do
            if lookup_modes[mode] then
                table.insert(modules, module)
                break
            end
        end
    end
    return modules
end

---@param modules lua_module[]
---@return lz.n.pack.Spec[]
_M.require_specs = function ()
    local specs = {}
    for _, mod in ipairs(_M.gather_specs()) do
        local ok, result = pcall(require, mod)
        if ok then
        else
            vim.notify("Could not require spec the spec " .. mod .. ": " .. result, vim.log.levels.ERROR)

        end
    end
end

return _M

