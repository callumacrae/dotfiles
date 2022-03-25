vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 0
}

vim.g.nvim_tree_special_files = {}

vim.g.nvim_tree_icons = {
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

local list = {
  {key = {"o", "<CR>"}, action = "edit"},
  {key = "<C-v>", action = "vsplit"},
  {key = "<C-x>", action = "split"},
  {key = "<C-t>", action = "tabnew"},
  {key = "<C-k>", action = "prev_sibling"},
  {key = "<C-j>", action = "next_sibling"},
  {key = "<C-h>", action = "parent_node"},
  {key = "<Tab>", action = "preview"},
  {key = "K", action = "first_sibling"},
  {key = "J", action = "last_sibling"},
  {key = "I", action = "toggle_ignored"},
  {key = "H", action = "toggle_dotfiles"},
  {key = "R", action = "refresh"},
  {key = "a", action = "create"},
  {key = "d", action = "remove"},
  {key = "m", action = "rename"},
  {key = "x", action = "cut"},
  {key = "y", action = "copy"},
  {key = "p", action = "paste"},
  {key = "[h", action = "prev_git_item"},
  {key = "]h", action = "next_git_item"},
  {key = "q", action = "close"},
  {key = "g?", action = "toggle_help"}
}

require'nvim-tree'.setup {
  hijack_cursor = true,
  view = {
    number = true,
    relativenumber = true,
    mappings = {
      custom_only = true,
      list = list
    }
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false
      }
    }
  }
}

vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>m', ':NvimTreeFindFileToggle<CR>', { silent = true })
