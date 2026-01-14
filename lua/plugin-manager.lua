vim.pack.add({ 'https://github.com/BirdeeHub/lze' }, { confirm = false })

---@type lze.pack.Spec[]
local plugin_specs = {}

local plugin_dir = vim.fn.stdpath('config') .. '/lua/plugins'
local files = vim.fn.globpath(plugin_dir, "*.lua", false, true)

for _, file in ipairs(files) do
    -- Convert file path to a Lua module name (e.g., "plugins.telescope")
    local module_name = file:match("lua/(plugins/.*)%.lua$"):gsub("/", ".")

    local ok, result = pcall(require, module_name)
    if ok and type(result) == "table" then
        if result[1] ~= nil then
            for _, spec in ipairs(result) do
                table.insert(plugin_specs, spec)
            end
        else
            table.insert(plugin_specs, result)
        end
    else
        vim.notify('Failed to load plugin spec: ' .. module_name.. '\nError: '..result, vim.log.levels.ERROR)
    end
end

vim.pack.add(plugin_specs, {
    load = function(p)
        local spec = p.spec.data or {}
        spec.name = p.spec.name
        require('lze').load(spec)
    end,
    confirm = true,
})
