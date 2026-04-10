local sup = require('supporter')

-- https://github.com/xzbdmw/colorful-menu.nvim
sup.insert('ft-plugin', {
    { 'colorful-menu', {
        'c',
        'cpp',
        'csharp',
        'dart',
        'go',
        'lua',
        'php',
        'python',
        'rust',
        'typescirpt',
        'zig',
    } }
})

-- https://cmp.saghen.dev/configuration/sources#community-sources
return {
    {
        src = 'https://github.com/saghen/blink.cmp',
        -- version = vim.version.range('1.*'),
        name = 'blink.cmp',
        ---@type lze.pack.Spec[]
        data = {
            event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
            dep_of = {
                'lspconfig',
                'nvim-dap',
                'obsidian.nvim',
                'otter.nvim',
            },
            lazy = true,
            run = function (data)
                vim.schedule(function()
                    vim.notify('Building blink.cmp...', vim.log.levels.INFO)
                end)

                -- Use the Nix command which is safer on NixOS
                -- 'data.path' is provided by the PackChanged event
                local obj = vim.system({ 'nix', 'run', '.#build-plugin' }, { cwd = data.path }):wait()
                -- local obj = vim.system({'cargo build --release' }, { cwd = data.path }):wait()


                vim.schedule(function()
                    if obj.code == 0 then
                        vim.notify('Blink.cmp built successfully!', vim.log.levels.INFO)
                    else
                        vim.notify('Blink.cmp build failed!', vim.log.levels.ERROR)
                        print(obj.stderr) -- Check :messages for errors
                    end
                end)
            end,
            after = function()
                require('blink.cmp').setup({
                    --
                    -- See :h blink-cmp-config-keymap for defining your own keymap
                    keymap = { preset = 'enter' },

                    appearance = {
                        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                        -- Adjusts spacing to ensure icons are aligned
                        nerd_font_variant = 'mono'
                    },

                    completion = {
                        list = {
                            selection = { preselect = true, auto_insert = true },
                        },
                        documentation = {
                            auto_show = true,
                            window = {
                                border = 'shadow',
                            },
                        },
                        menu = {
                            border = 'none',
                            draw = {
                                columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'source_name', gap = 1 } },
                                components = {
                                    label = {
                                        width = { fill = true, max = 60 },
                                        text = function(ctx)
                                            local highlights_info = require('colorful-menu').blink_highlights(ctx)
                                            if highlights_info ~= nil then
                                                -- Or you want to add more item to label
                                                return highlights_info.label
                                            else
                                                return ctx.label
                                            end
                                        end,
                                        highlight = function(ctx)
                                            local highlights = {}
                                            local highlights_info = require('colorful-menu').blink_highlights(ctx)
                                            if highlights_info ~= nil then
                                                highlights = highlights_info.highlights
                                            end
                                            for _, idx in ipairs(ctx.label_matched_indices) do
                                                table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                                            end
                                            -- Do something else
                                            return highlights
                                        end,
                                    },
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
                        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
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
                            snippets = {
                                opts = {
                                    friendly_snippets = true,

                                    -- see the list of frameworks in: https://github.com/rafamadriz/friendly-snippets/tree/main/snippets/frameworks
                                    -- and search for possible languages in: https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
                                    -- the following is just an example, you should only enable the frameworks that you use
                                    -- extended_filetypes = {
                                    --     markdown = { 'jekyll' },
                                    --     sh = { 'shelldoc' },
                                    --     php = { 'phpdoc' },
                                    --     cpp = { 'unreal' }
                                    -- }
                                },
                            },
                            lazydev = {
                                name = 'LazyDev',
                                module = 'lazydev.integrations.blink',
                                score_offset = 100
                            },

                            -- Use the thesaurus source
                            thesaurus = {
                                name = 'thesaurus',
                                module = 'blink-cmp-words.thesaurus',
                                -- All available options
                                opts = {
                                    -- A score offset applied to returned items.
                                    -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
                                    score_offset = 0,

                                    -- Default pointers define the lexical relations listed under each definition,
                                    -- see Pointer Symbols below.
                                    -- Default is as below ('antonyms', 'similar to' and 'also see').
                                    definition_pointers = { '!', '&', '^' },

                                    -- The pointers that are considered similar words when using the thesaurus,
                                    -- see Pointer Symbols below.
                                    -- Default is as below ('similar to', 'also see' }
                                    similarity_pointers = { '&', '^' },

                                    -- The depth of similar words to recurse when collecting synonyms. 1 is similar words,
                                    -- 2 is similar words of similar words, etc. Increasing this may slow results.
                                    similarity_depth = 2,
                                },
                            },

                            -- Use the dictionary source
                            dictionary = {
                                name = 'dictoinary',
                                module = 'blink-cmp-words.dictionary',
                                -- All available options
                                opts = {
                                    -- The number of characters required to trigger completion.
                                    -- Set this higher if completion is slow, 3 is default.
                                    dictionary_search_threshold = 3,

                                    -- See above
                                    score_offset = 0,

                                    -- See above
                                    definition_pointers = { '!', '&', '^' },
                                },
                            },
                        },
                        per_filetype = {
                            text = { 'dictionary' },
                            markdown = { 'thesaurus' },
                        },
                    },

                    -- See the fuzzy documentation for more information
                    fuzzy = { implementation = 'prefer_rust_with_warning' },
                })
            end,
        },
    },
    {
        src = 'https://github.com/archie-judd/blink-cmp-words',
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
                'blink.cmp'
            },
            lazy = true,
        },
    },
    {
        src = 'https://github.com/xzbdmw/colorful-menu.nvim',
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
                'blink.cmp'
            },
            lazy = true,
            after = function ()
                require("colorful-menu").setup()
            end
        },
    },
    {
        src = 'https://github.com/rafamadriz/friendly-snippets',
        ---@type lze.pack.Spec[]
        data = {
            dep_of = {
                'blink.cmp'
            },
            lazy = true,
        },
    },
}
