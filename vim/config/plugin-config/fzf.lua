local fzf = require "fzf-lua"
local actions = require "fzf-lua.actions"

fzf.setup({
  actions = {
    files = {
      ["default"]     = actions.file_edit_or_qf,
      ["ctrl-x"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["alt-q"]       = actions.file_sel_to_qf,
    }
  }
})

fzf.register_ui_select()

function _G.FzfFilesWithQuery(query)
  fzf.files({ fzf_opts = { ['--query'] = query } })
end

vim.api.nvim_set_keymap('n', '<c-p><c-p>', "<cmd>NvimTreeClose<CR><cmd>lua require('fzf-lua').builtin()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<c-p><c-r>', "<cmd>NvimTreeClose<CR><cmd>lua require('fzf-lua').resume()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<c-p><c-f>', "<cmd>NvimTreeClose<CR><cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<c-p><c-g>', "<cmd>NvimTreeClose<CR><cmd>lua require('fzf-lua').grep_project()<CR>", { silent = true })

vim.api.nvim_set_keymap('n', '<leader>gr', "<cmd>NvimTreeClose<CR><cmd>lua require('fzf-lua').lsp_references()<CR>", { silent = true })

vim.api.nvim_set_keymap('n', '<leader>gf', "yiq<cmd>lua _G.FzfFilesWithQuery(vim.fn.getreg('\"'))<CR>", { silent = true })
vim.api.nvim_set_keymap('v', '<leader>gf', "y<cmd>lua _G.FzfFilesWithQuery(vim.fn.getreg('\"'))<CR>", { silent = true })
vim.api.nvim_set_keymap('v', '<c-p><c-f>', "y<cmd>lua _G.FzfFilesWithQuery(vim.fn.getreg('\"'))<CR>", { silent = true })

vim.api.nvim_set_keymap('n', '<leader>*', "<cmd>lua require('fzf-lua').grep_cword()<CR>", { silent = true })
vim.api.nvim_set_keymap('v', '<leader>*', "<cmd>lua require('fzf-lua').grep_visual()<CR>", { silent = true })
vim.api.nvim_set_keymap('v', '<c-p><c-g>', "<cmd>lua require('fzf-lua').grep_visual()<CR>", { silent = true })

-- todo:
-- - Command to run command from specific directory from nvim-tree
-- - Use ag!
