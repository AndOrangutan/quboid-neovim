return {
    {
        src = 'https://github.com/saghen/blink.cmp',
        ---@type lze.pack.Spec[]
        data = {
            event = { 'LspAttach' },
            dep_of = { 'lspconfig' },
            tag = '1.*',
            lazy = true,
            after = function()
                require('blink.cmp').setup({
                    --
                    -- See :h blink-cmp-config-keymap for defining your own keymap
                    keymap = { preset = 'default' },

                    appearance = {
                        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                        -- Adjusts spacing to ensure icons are aligned
                        nerd_font_variant = 'mono'
                    },

                    completion = {
                        documentation = { auto_show = true },
                        menu = {
                            draw = {
                                components = {
                                    kind_icon = {
                                        text = function(ctx)
                                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                            return kind_icon
                                        end,
                                        -- (optional) use highlights from mini.icons
                                        highlight = function(ctx)
                                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                            return hl
                                        end,
                                    },
                                    kind = {
                                        -- (optional) use highlights from mini.icons
                                        highlight = function(ctx)
                                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                            return hl
                                        end,
                                    }
                                }
                            }
                        }
                    },


                    -- Default list of enabled providers defined so that you can extend it
                    -- elsewhere in your config, without redefining it, due to `opts_extend`
                    sources = {
                        default = { 'lsp', 'path', 'snippets', 'buffer' },
                        providers = {
                            buffer = {
                                opts = {
                                    -- get all buffers, even ones like neo-tree
                                    get_bufnrs = vim.api.nvim_list_bufs
                                }
                            },
                            cmdline = {
                                -- ignores cmdline completions when executing shell commands
                                enabled = function()
                                    return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
                                end
                            },
                            path = {
                                opts = {
                                    get_cwd = function(_)
                                        return vim.fn.getcwd()
                                    end,
                                },
                            },
                        },
                    },

                    -- See the fuzzy documentation for more information
                    fuzzy = { implementation = "prefer_rust_with_warning" },
                })
        end,
    },
},
}
