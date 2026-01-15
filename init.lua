local def = require('defaults')
local sup = require('supporter')

require('config').init()

sup.init({
    { 'ft-lsp', 'LSP x Filetype', def.ft_support, {} },
    { 'ft-plugin', 'Plugins x Filetype', def.ft_support, {} },
    { 'ft-exclude', 'Exclude x Filetype', {}, {} },
})

require('plugin-manager')

require('highlights')

sup.gen()
