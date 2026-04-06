
local sup = require('supporter')

sup.insert('ft-dap', {
    { 'codelldb', { 'c', 'cpp', 'rust' } }, -- TODO: Add cpp and rust
})

local dap_support = require('supporter').by('ft-dap')
return {
    {
        src = 'https://codeberg.org/mfussenegger/nvim-dap',
        name = 'nvim-dap',
        ---@type lze.pack.Spec[]
        data = {
            lazy = true,
            ft = dap_support,
            cmd = {
                'DapContinue',
                'DapNew',
                'DapStepInto',
                'DapStepOver',
                'DapToggleBreakpoint',
            },
            after = function()
                -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
                -- setup dap config by VsCode launch.json file
                local vscode = require("dap.ext.vscode")
                local json = require("plenary.json")
                vscode.json_decode = function(str)
                    return vim.json.decode(json.json_strip_comments(str))
                end

                local icons = require('icons')

                vim.fn.sign_define('DapBreakpoint',
                    { text = icons.ui.circle, texthl = 'DiagnosticError', linehl = '', numhl = '' })
                vim.fn.sign_define('DapStopped',
                    { text = icons.ui.circle_stop, texthl = 'DiagnosticError', linehl = '', numhl = '' })

                require('dap_cfg')
            end,
            keys = {
                { lhs = '<leader>dB', rhs = function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition (dap)' },
                { lhs = '<leader>db', rhs = function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint (dap)' },
                { lhs = '<leader>dc', rhs = function() require('dap').continue() end, desc = 'Run/Continue (dap)' },
                -- { lhs = '<leader>da', rhs = function() require('dap').continue({ before = get_args }) end, desc = 'Run with Args (dap)' },
                { lhs = '<leader>dC', rhs = function() require('dap').run_to_cursor() end, desc = 'Run to Cursor (dap)' },
                { lhs = '<leader>dg', rhs = function() require('dap').goto_() end, desc = 'Go to Line (No Execute) (dap)' },
                { lhs = '<leader>di', rhs = function() require('dap').step_into() end, desc = 'Step Into (dap)' },
                { lhs = '<leader>dj', rhs = function() require('dap').down() end, desc = 'Down (dap)' },
                { lhs = '<leader>dk', rhs = function() require('dap').up() end, desc = 'Up (dap)' },
                { lhs = '<leader>dl', rhs = function() require('dap').run_last() end, desc = 'Run Last (dap)' },
                { lhs = '<leader>do', rhs = function() require('dap').step_out() end, desc = 'Step Out (dap)' },
                { lhs = '<leader>dO', rhs = function() require('dap').step_over() end, desc = 'Step Over (dap)' },
                { lhs = '<leader>dP', rhs = function() require('dap').pause() end, desc = 'Pause (dap)' },
                { lhs = '<leader>dr', rhs = function() require('dap').repl.toggle() end, desc = 'Toggle REPL (dap)' },
                { lhs = '<leader>ds', rhs = function() require('dap').session() end, desc = 'Session (dap)' },
                { lhs = '<leader>dt', rhs = function() require('dap').terminate() end, desc = 'Terminate (dap)' },
            },
        },
    },
}
