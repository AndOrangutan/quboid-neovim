vim.pack.add({ "https://github.com/lumen-oss/lz.n" })

local lz = require("lz.n")

--lz.load("plugins")
---@type lz.n.pack.Spec[]
local plugin_specs = {}
--- Add the plugins, replacing the built-in `load` function
--- with lz.n's implementation.
vim.pack.add(plugin_specs, { load = lz.load })

require('plugins').require_specs()
