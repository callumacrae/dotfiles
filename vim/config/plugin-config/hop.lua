require'hop'.setup({
  case_insensitive = false
})

vim.api.nvim_set_keymap('', '<leader>fw', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>", { silent = true })
vim.api.nvim_set_keymap('', '<leader>fW', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>", { silent = true })
vim.api.nvim_set_keymap('', '<leader>fe', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>", { silent = true })
vim.api.nvim_set_keymap('', '<leader>fE', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>", { silent = true })
vim.api.nvim_set_keymap('', '<leader>fr', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>", { silent = true })
vim.api.nvim_set_keymap('', '<leader>fR', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>", { silent = true })

vim.api.nvim_set_keymap('', '<leader>f/', "<cmd>lua require'hop'.hint_patterns()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>f*', "yiw<cmd>lua require'hop'.hint_patterns({}, vim.fn.getreg('\"'))<CR>", { silent = true })
vim.api.nvim_set_keymap('v', '<leader>f*', "y<cmd>lua require'hop'.hint_patterns({}, vim.fn.getreg('\"'))<CR>", { silent = true })
