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

local function has_fugitive_buffers()
  local buffers = vim.fn.getbufinfo({ bufloaded = 1 })
  for _, buffer in ipairs(buffers) do
    if buffer.name:find('^fugitive://') then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function ()
    -- Test whether quickfix list is :G mergetool
    local qfTitle = vim.fn.getqflist({ title = true }).title
    if (not qfTitle or not qfTitle:find(":Git") or not qfTitle:find('mergetool')) then
      return
    end

    -- Test whether buffer is in quickfix list
    local bufnr = vim.fn.bufnr('%')
    local qfItems = vim.fn.getqflist({ items = true })
    local isInQuickfix = false
    for _, item in ipairs(qfItems.items) do
      if item.bufnr == bufnr then
        isInQuickfix = true
        break
      end
    end
    if not isInQuickfix then
      return
    end

    -- Test whether file has merge conflict markers
    if vim.fn.search('<<<<<<<', 'wn') == 0 then
      return
    end

    -- Already in fugitive session
    if has_fugitive_buffers() then
      return
    end

    -- Defer because otherwise it doesn't work for some reason
    vim.defer_fn(function ()
      vim.cmd('Gdiffsplit!')
    end, 1)
  end,
  group = fugitive,
});
