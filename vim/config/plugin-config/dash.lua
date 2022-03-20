require('dash').setup({
  search_engine = 'google',
  debounce = 10,
  file_type_keywords = {
    javascript = { 'js', 'node' },
    typescript = { 'js', 'ts', 'node' },
    vue = { 'vue', 'js', 'ts', 'css' },
    swift = { 'apple' },
  }
})

vim.api.nvim_set_keymap('n', '<leader>K', "<cmd>DashWord<CR>", { silent = true })
