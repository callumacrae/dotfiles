require('dash').setup({
  search_engine = 'google',
  debounce = 10,
  vue = { 'vue', 'javascript', 'typescript', 'css' }
})

vim.api.nvim_set_keymap('n', '<leader>K', "<cmd>DashWord<CR>", { silent = true })
