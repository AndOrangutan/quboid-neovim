return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', 'init.lua' },
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            hint = {
                enable = true,
                arrayIndex = 'Disable',
                setType = true,
            },
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                -- This makes the server aware of all your installed plugins
                library = (function()
                    local lib = { vim.env.VIMRUNTIME }
                    for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
                        if path:match("/pack/") then
                            table.insert(lib, path)
                            local lua_path = path .. "/lua"
                            if vim.fn.isdirectory(lua_path) == 1 then
                                table.insert(lib, lua_path)
                            end
                        end
                    end
                    return lib
                end)(),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
            signatureHelp = { enable = true },
        },
    },
}
