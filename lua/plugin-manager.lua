local build_tasks = {}

---@type lze.pack.Spec[]
local plugin_specs = {}
local plugin_dir = vim.fn.stdpath('config') .. '/lua/plugins'
local files = vim.fn.globpath(plugin_dir, "*.lua", false, true)

for _, file in ipairs(files) do
    -- Convert file path to a Lua module name (e.g., "plugins.telescope")
    local module_name = file:match("lua/(plugins/.*)%.lua$"):gsub("/", ".")
    local ok, result = pcall(require, module_name)

    if ok and type(result) == 'table' then
        local items = result[1] ~= nil and result or { result }
        for _, spec in ipairs(items) do
            -- Populate our lookup table before Neovim processes the spec
            if spec.name and spec.data and spec.data.run then
                build_tasks[spec.name] = spec.data.run
            end
            table.insert(plugin_specs, spec)
        end
    end
end

-- https://github.com/neovim/neovim/pull/35360#issuecomment-3212327279
local augroup = vim.api.nvim_create_augroup('build_system', { clear = false })
vim.api.nvim_create_autocmd('PackChanged', {
    group = augroup,
    pattern = '*',
    callback = function(e)
        local data = e.data
        local name = data.spec.name
        local run_task = build_tasks[name]

        if data.kind ~= 'delete' and run_task ~= nil then
            vim.notify('Found run task for ' .. data.spec.name)
            local ok, out = pcall(run_task, data)
            if not ok then
                vim.notify("Run Task Error: " .. tostring(out), vim.log.levels.ERROR)
            end
        end
    end,
})

vim.pack.add({ 'https://github.com/BirdeeHub/lze' }, { confirm = false })

vim.pack.add(plugin_specs, {
    load = function(p)
        local spec = p.spec.data or {}
        spec.name = p.spec.name
        require('lze').load(spec)
    end,
    confirm = true,
})

