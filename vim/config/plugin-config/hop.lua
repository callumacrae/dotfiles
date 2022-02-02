require'hop'.setup()

vim.api.nvim_set_keymap('', '<leader>fw', "<cmd>HopWord<CR>", { silent = true })
vim.api.nvim_set_keymap('', '<leader>fe', "<cmd>HopChar1<CR>", { silent = true })
vim.api.nvim_set_keymap('', '<leader>fr', "<cmd>HopChar2<CR>", { silent = true })
