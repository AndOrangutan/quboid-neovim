local def = require('defaults')
local sup = require('supporter')

require('config').init()

sup.init({
    { 'ft-lsp', 'LSP x Filetype', def.ft_support, {} },
    { 'ft-plugin', 'Plugins x Filetype', def.ft_support, {} },
    { 'ft-exclude', 'Exclude x Filetype', {}, {} },
    { 'bt-exclude', 'Exclude x Buffertype', {}, {} },
})

sup.insert('ft-exclude', {
    { 'default', {
        'man'
    } }
})

sup.insert('bt-exclude', {
    { 'default', {
        'help',
        'nofile',
        'prompt',
        'quickfix',
    } }
})
require('plugin-manager')

require('highlights')

sup.gen()
