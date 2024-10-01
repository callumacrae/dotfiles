
local function nvim_tree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

  vim.keymap.set('n', 'o', api.node.open.edit, opts)
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts)
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts)
  vim.keymap.set('n', "<C-x>", api.node.open.horizontal, opts)
  vim.keymap.set('n', "<C-t>", api.node.open.tab, opts)
  vim.keymap.set('n', "<C-k>", api.node.navigate.sibling.prev, opts)
  vim.keymap.set('n', "<C-j>", api.node.navigate.sibling.next, opts)
  vim.keymap.set('n', "<C-h>", api.node.navigate.parent, opts)
  vim.keymap.set('n', "<Tab>", api.node.open.preview, opts)
  vim.keymap.set('n', "K", api.node.navigate.sibling.first, opts)
  vim.keymap.set('n', "J", api.node.navigate.sibling.last, opts)
  vim.keymap.set('n', "R", api.tree.reload, opts)
  vim.keymap.set('n', "a", api.fs.create, opts)
  vim.keymap.set('n', "d", api.fs.remove, opts)
  vim.keymap.set('n', "m", api.fs.rename, opts)
  vim.keymap.set('n', "x", api.fs.cut, opts)
  vim.keymap.set('n', "y", api.fs.copy.node, opts)
  vim.keymap.set('n', "p", api.fs.paste, opts)
  vim.keymap.set('n', "[h", api.node.navigate.git.prev, opts)
  vim.keymap.set('n', "]h", api.node.navigate.git.next, opts)
  vim.keymap.set('n', "q", api.tree.close, opts)
  vim.keymap.set('n', "g?", api.tree.toggle_help, opts)
end

require('nvim-tree').setup({
  hijack_cursor = true,
  view = {
    number = true,
    relativenumber = true,
  },
  on_attach = nvim_tree_on_attach,
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false
      }
    }
  },
  renderer = {
    special_files = {},
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = false
      },
      glyphs = {
        default = ' ',
        git = {
          unstaged = "✹",
          staged = "✚",
          unmerged = "",
          renamed = "➜",
          untracked = "✭",
          deleted = "✖",
          ignored = "☒"
        },
        folder = {
          default = "",
          open = "",
        }
      }
    }
  },
})

vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>m', ':NvimTreeFindFileToggle<CR>', { silent = true })
