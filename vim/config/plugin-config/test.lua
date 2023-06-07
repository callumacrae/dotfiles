vim.g['test#strategy'] = 'vimux'
vim.g['test#preserve_screen'] = 1
vim.g['test#echo_command'] = 0

vim.g['test#javascript#jest#file_pattern'] = '\\v(__tests__/.*|(spec|test|unit))\\.(js|jsx|ts|tsx)$'
vim.g['test#javascript#jest#options'] = '--json --outputFile .jest-results --testLocationInResults'
vim.g['test#javascript#vitest#file_pattern'] = '\\v(__tests__/.*|(spec|test|unit))\\.(js|jsx|ts|tsx)$'
-- vim.g['test#javascript#vitest#options'] = '--reporter json --outputFile .vitest-results'
vim.g['test#javascript#playwright#file_pattern'] = '\\v(__tests__/.*|(spec|test|setup))\\.(js|jsx|ts|tsx)$'
vim.g['test#javascript#playwright#options'] = '--reporter=line'

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { '*/__tests__/*', '*.spec.*', '*_spec.*', '*.test.*', '*.unit.*', '*.setup.*' },
  callback = function()
    -- Handle multiple test runners by inspecting file contents
    if vim.fn.search('@playwright\\/test', 'wn') ~= 0 then
      vim.g['test#javascript#runner'] = 'playwright'
    elseif vim.fn.search('\\scy\\.[a-z]', 'wn') ~= 0 then
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

vim.api.nvim_set_keymap('n', '<leader>ja', "<cmd>TestSuite<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jf', "<cmd>TestFile<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jdf', "<cmd>TestFile --debug<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>js', "<cmd>TestNearest<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jds', "<cmd>TestNearest --debug<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jc', "<cmd>TestNearest<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jdc', "<cmd>TestNearest --debug<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jl', "<cmd>TestLast<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jdl', "<cmd>TestLast --debug<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jj', "<cmd>TestLast<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>jdj', "<cmd>TestLast --debug<cr>", { silent = true })

local jestJqScript = ([[
def failures:
    . as $result
    | .assertionResults
    | map(select(.status == "failed"))
    | map({ file: $result.name, location, fullName, title });

.testResults
    | map(select(.status == "failed"))
    | reduce .[] as $result ([]; . + ($result | failures))
    | .[]
    | "\(.file):\(.location.line // 0):\(.location.column // 0):\(.title)"
  ]]):gsub('\n', ' ')

local function test_quickfix()
  local runner = vim.fn['test#determine_runner'](vim.fn.expand('%'))

  if runner == 0 then
    vim.api.nvim_err_writeln('Error: not a test file')
  elseif runner == 'javascript#jest' then
    vim.fn.setqflist({}, ' ', { title = 'Jest Errors' })
    vim.cmd("caddexpr system('cat .jest-results | jq --raw-output ''" .. jestJqScript .. "''')")
    vim.cmd('copen')
  elseif runner == 'javascript#vitest' then
    vim.fn.setqflist({}, ' ', { title = 'Vitest Errors' })
    vim.cmd("caddexpr system('cat .vitest-results | jq --raw-output ''" .. jestJqScript .. "''')")
    vim.cmd('copen')
  else
    vim.api.nvim_err_writeln('Error: :JestQf not supported with ' .. runner .. ' runner')
  end
end

vim.api.nvim_create_user_command('TestQf', test_quickfix, {})
vim.api.nvim_set_keymap('n', '<leader>jq', "<cmd>TestQf<cr>", { silent = true })
