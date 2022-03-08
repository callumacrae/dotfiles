local fzf = require "fzf-lua"

function _G.FzfFilesWithQuery(query)
  fzf.files({ fzf_opts = { ['--query'] = query } })
end

vim.api.nvim_set_keymap('n', '<c-p>', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
-- vim.api.nvim_set_keymap('n', '<c-P>', "<cmd>lua require('fzf-lua').builtin()<CR>", { silent = true })
vim.cmd("command! Ag lua require('fzf-lua').grep_project()<CR>", { silent = true })

vim.api.nvim_set_keymap('n', '<leader>gf', "yiq<cmd>lua _G.FzfFilesWithQuery(vim.fn.getreg('\"'))<CR>", { silent = true })
vim.api.nvim_set_keymap('v', '<leader>gf', "y<cmd>lua _G.FzfFilesWithQuery(vim.fn.getreg('\"'))<CR>", { silent = true })

vim.api.nvim_set_keymap('n', '<leader>*', "<cmd>lua require('fzf-lua').grep_cword()<CR>", { silent = true })
vim.api.nvim_set_keymap('v', '<leader>*', "<cmd>lua require('fzf-lua').grep_visual()<CR>", { silent = true })

-- todo:
-- - Command to run command from specific directory from nvim-tree
-- - Easier way to get into builtin()?
-- - Use ag!
