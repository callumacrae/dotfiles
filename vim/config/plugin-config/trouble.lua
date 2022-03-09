local Trouble = require('trouble')

Trouble.setup {
  icons = false,
  padding = false,
  auto_open = false, -- too annoying, replaced by autocmd below
  auto_close = false
}

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})

function _G.trouble_if_trouble()
  require("trouble.providers").get(vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf(), function(results)
    if #results > 0 then
      Trouble.open()
    else
      Trouble.close()
    end
  end, require("trouble.config").options)
end

-- todo: replace when autocmd-lua api available in 0.7
vim.api.nvim_command([[
  augroup TroubleOnSave
  autocmd BufWritePost * :call v:lua.trouble_if_trouble()
  augroup END
]])
