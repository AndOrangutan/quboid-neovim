local _M = {}
-- TODO: add keybinds
_M.setup_on_attach = function ()
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function (args)
            local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

            -------------
            -- Keymaps --
            -------------
            if client:supports_method('textDocument/codeAction') then
                -- TODO: replace fzf-lua
                vim.keymap.set({'n', 'v'}, '<lader>ca', vim.lsp.buf.code_action, { buffer = args.buf, desc = 'Goto [i]mplementation (LSP)' })
            end
            if client:supports_method('textDocument/declaration') then
                vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, { buffer = args.buf, desc = 'Goto [D]eclaration (LSP)' })
            end
            if client:supports_method('textDocument/definition') then
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Goto [d]efinition (LSP)' })
            end
            if client:supports_method('textDocument/formatting') then
                vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = args.buf, desc = 'Goto [d]efinition (LSP)' })
            end
            if client:supports_method('textDocument/hover') then
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf, desc = 'Goto [k]ick up Hover (LSP)' })
            end
            if client:supports_method('textDocument/implementation') then
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = args.buf, desc = 'Goto [i]mplementation (LSP)' })
            end
            if client:supports_method('textDocument/references') then
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = args.buf, desc = 'Goto [i]mplementation (LSP)' })
            end
            if client:supports_method('textDocument/rename') then
                vim.keymap.set('n', 'rn', vim.lsp.buf.rename, { buffer = args.buf, desc = 'Goto [i]mplementation (LSP)' })
            end
            if client:supports_method('textDocument/typeDefinition') then
                vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = args.buf, desc = 'Goto [i]mplementation (LSP)' })
            end

            if client:supports_method('textDocument/completion') then
                -- Optional: trigger autocompletion on EVERY keypress. May be slow!
                local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
                client.server_capabilities.completionProvider.triggerCharacters = chars

                vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = false })
            end

            -- Auto-format ("lint") on save.
            -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
            if not client:supports_method('textDocument/willSaveWaitUntil') and client:supports_method('textDocument/formatting') then
                -- vim.api.nvim_create_autocmd('BufWritePre', {
                --     group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
                --     buffer = args.buf,
                --     callback = function()
                --         vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                --     end,
                -- })
            end
        end,
    })
end


-- Generate capabilities
_M.get_capabilities = function ()
    local blink_ok, blink = pacll(require, 'blink.cmp')
    local capabilities = {}
    local def_capabilities = {
        offsetEncoding = { 'utf-16' }
    }
    if blink_ok then
        capabilities = require('blink.cmp').get_lsp_capabilities(def_capabilities)
    else
        capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, def_capabilities)
    end
    -- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    return capabilities
end

return _M
