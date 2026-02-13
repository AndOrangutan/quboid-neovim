local sup = require('supporter')

sup.insert('ft-lsp', {
    { 'lua-language-server', { 'lua' } },
})

return {
    {
        src = 'https://github.com/neovim/nvim-lspconfig',
        ---@type lze.Spec[]
        data = {
            lazy = true,
            ft  = require('supporter').by('ft-lsp'),
            dep_of = {
            },
            cmd = {
            },
            before = function ()
                local defaults = require('defaults')
                local icons = require('icons')
                local lsp = require('lsp')

                lsp.setup_on_attach()

                -- Override border
                local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
                function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                   opts = opts or {}
                    opts.border = opts.border or defaults.border
                    return orig_util_open_floating_preview(contents, syntax, opts, ...)
                end

                -- Set up kind icons
                local kinds = vim.lsp.protocol.CompletionItemKind
                for i, kind in ipairs(kinds) do
                    kinds[i] = MiniIcons.get('lsp', kind) or kind
                end

                -- Setup diagnostic icons
                for type, icon in pairs(icons.lsp_diag) do
                    local hl = 'DiagnosticSign' .. type
                    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                end

                vim.diagnostic.config({
                    -- prefix = '■',
                    virtual_text = false,
                    float = {
                        source = 'always',
                        thing = 'test',
                    },
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = icons.lsp_diag.Error,
                            [vim.diagnostic.severity.WARN]  = icons.lsp_diag.Warn,
                            [vim.diagnostic.severity.HINT]  = icons.lsp_diag.Hint,
                            [vim.diagnostic.severity.INFO]  = icons.lsp_diag.Info,
                        }
                    },
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                })

                local lsp_servers = require('supporter').is('ft-lsp')
                vim.lsp.enable(lsp_servers)
            end,
            keys = {
                { lhs = '<leader>e', rhs = '<cmd>lua vim.diagnostic.open_float()<cr>', desc = '[e]pand Diagnostics (lsp)'},
                { lhs = '[d', rhs = '<cmd>lua vim.diagnostic.goto_prev({float = true})<cr>', desc = 'Goto Prev [d]iagnostic (lsp)'},
                { lhs = ']d', rhs = '<cmd>lua vim.diagnostic.goto_next({float = true})<cr>', desc = 'Goto Next [d]iagnostic (lsp)'},

            },
        },
    },
    {
        src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim',
        ---@type lze.pack.Spec[]
        data = {
            event = { 'LspAttach' },
            lazy = true,
            after = function()
                vim.diagnostic.open_float = require('tiny-inline-diagnostic.override').open_float
                local icons = require('icons')
                require('tiny-inline-diagnostic').setup({
                    -- preset = 'classic',
                    signs = {
                        left = '',
                        right = '',
                        -- diag = '●',
                        arrow = '    ',
                        up_arrow = '    ',
                        vertical = ' '..icons.ui.bar_thick..' ',
                        vertical_end = ' '..icons.ui.bar_thick_elbow..' ',
                    },
                    blend = {
                        factor = 0.22,
                    },
                    hl = {
                        background = 'NormalFloat',
                    },
                    options = {
                        use_icons_from_diagnostic = true,
                        multilines = {
                            enabled = false,
                        },
                        show_source = {
                            enabled = true,
                        },
                    },
                })
            end,
        },
    },
}
