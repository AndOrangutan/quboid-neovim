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
            runtime = {
                version = 'LuaJIT',
            },
            signatureHelp = { enabled = true },
            workspace = {
                -- This makes the server aware of all your installed plugins
                library = (function()
                    local lib = {
                        vim.env.VIMRUNTIME,
                    }
                    -- Use a protected call to gather runtime files
                    -- This ensures all plugins (including lze) are added to the path
                    local paths = vim.api.nvim_get_runtime_file("", true)
                    for _, path in ipairs(paths) do
                        table.insert(lib, path)
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
