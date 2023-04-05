vim.g['test#strategy'] = 'vimux';
vim.g['test#javascript#jest#file_pattern'] = '\\v(__tests__/.*|(spec|test|unit))\\.(js|jsx|ts|tsx)$'
vim.g['test#javascript#playwright#options'] = '--reporter line'

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { '*/__tests__/*', '*.spec.*', '*_spec.*', '*.test.*', '*.unit.*' },
  callback = function()
    -- Handle multiple test runners by inspecting file contents
    if vim.fn.search('@playwright\\/test') ~= 0 then
      vim.g['test#javascript#runner'] = 'playwright'
    elseif vim.fn.search('\\scy\\.[a-z]') ~= 0 then
      vim.g['test#javascript#runner'] = 'cypress'
    else
      vim.g['test#javascript#runner'] = nil
    end

    -- Use npm / yarn commands when available
    local packageFile = vim.fn.findfile('package.json', vim.fn.getcwd() .. ';')
    if packageFile ~= '' then
      local package = vim.fn.json_decode(vim.fn.readfile(packageFile))

      local yarnLockFile = vim.fn.findfile('yarn.lock', vim.fn.getcwd() .. ';')
      local yarnOrNpm = yarnLockFile ~= '' and 'yarn' or 'npm'

      if package.scripts ~= nil then
        if package.scripts['test:unit'] ~= nil then
          vim.g['test#javascript#jest#executable'] = yarnOrNpm .. ' run test:unit'
        else
          vim.g['test#javascript#jest#executable'] = nil
        end

        if package.scripts['test:e2e'] ~= nil then
          vim.g['test#javascript#playwright#executable'] = yarnOrNpm .. ' run test:e2e'
          vim.g['test#javascript#cypress#executable'] = yarnOrNpm .. ' run test:e2e'
        else
          vim.g['test#javascript#playwright#executable'] = nil
          vim.g['test#javascript#cypress#executable'] = nil
        end
      end
    end
  end
})

vim.api.nvim_set_keymap('n', '<leader>jf', "<cmd>TestFile<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>js', "<cmd>TestNearest<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jl', "<cmd>TestLast<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jj', "<cmd>TestLast<cr>", { silent = true })
