local fugitive = vim.api.nvim_create_augroup('fugitive_au', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'fugitive',
    callback = function()
      vim.api.nvim_win_set_height(0, 20)
      vim.opt_local.winfixheight = true

      vim.keymap.set('n', 'gp', function ()
        vim.cmd('call VimuxRunCommand("git push")')
        vim.api.nvim_win_close(0, true)
      end, { buffer = true })
    end,
    group = fugitive,
  })

