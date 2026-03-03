return {
    {
        src = 'https://github.com/mrjones2014/smart-splits.nvim',
        ---@type lze.pack.Spec[]
        data = {
            lazy = false,
            keys = {
                { lhs = '<C-A-h>', rhs = '<cmd>lua require("smart-splits").resize_left()<cr>',       desc = 'Resize Left (smart-split)' },
                { lhs = '<C-A-j>', rhs = '<cmd>lua require("smart-splits").resize_down()<cr>',       desc = 'Resize Down (smart-split)' },
                { lhs = '<C-A-k>', rhs = '<cmd>lua require("smart-splits").resize_up()<cr>',         desc = 'Resize Up (smart-split)' },
                { lhs = '<C-A-l>', rhs = '<cmd>lua require("smart-splits").resize_right()<cr>',      desc = 'Resize Right (smart-split)' },
                -- moving between splits
                { lhs = '<A-h>',   rhs = '<cmd>lua require("smart-splits").move_cursor_left()<cr>',  desc = 'Move Left (smart-split)' },
                { lhs = '<A-j>',   rhs = '<cmd>lua require("smart-splits").move_cursor_down()<cr>',  desc = 'Move Down (smart-split)' },
                { lhs = '<A-k>',   rhs = '<cmd>lua require("smart-splits").move_cursor_up()<cr>',    desc = 'Move Up (smart-split)' },
                { lhs = '<A-l>',   rhs = '<cmd>lua require("smart-splits").move_cursor_right()<cr>', desc = 'Move Right (smart-split)' },
                -- swapping buffers between windows
                { lhs = '<A-H>',   rhs = '<cmd>lua require("smart-splits").swap_buf_left()<cr>',     desc = 'Swap Left (smart-split)' },
                { lhs = '<A-J>',   rhs = '<cmd>lua require("smart-splits").swap_buf_down()<cr>',     desc = 'Swap Down (smart-split)' },
                { lhs = '<A-K>',   rhs = '<cmd>lua require("smart-splits").swap_buf_up()<cr>',       desc = 'Swap Up (smart-split)' },
                { lhs = '<A-L>',   rhs = '<cmd>lua require("smart-splits").swap_buf_right()<cr>',    desc = 'Swap Right (smart-split)' },
            },
        },
    },
}
