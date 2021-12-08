require'hop'.setup()

vim.api.nvim_set_keymap('n', '<leader>fw', ":HopWord<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>fe', ":HopChar1<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>fr', ":HopChar2<CR>", { silent = true })
