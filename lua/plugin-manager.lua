vim.pack.add({ "https://github.com/lumen-oss/lz.n" })

---@type lz.n.pack.Spec[]
local plugins = {
    -- {
    --     src = "https://github.com/NTBBloodBath/sweetie.nvim",
    --     data = {
    --         colorscheme = "sweetie",
    --     },
    -- },
}

vim.pack.add(plugins, { load = require("lz.n").load })
