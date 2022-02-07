-- Based on kubejm/jest.nvim, but copies to clipboard and has better matching
local function run_jest(args)
  local cmd = vim.g.jest_cmd or 'npx jest'
  local c_file = vim.fn.getreg('%')
  vim.fn.setreg('+', cmd .. ' --runTestsByPath ' .. c_file .. ' ' .. args)
  print('Copied jest command to clipboard')
end

function _G.jest_file()
  run_jest('')
end

local function jest_single_on_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_command('silent normal $va)o2hy')
  local str = vim.fn.getreg('"')
  local _, _, test_name = string.find(str, "%s*it%(%s*['\"](.+)['\"]")
  vim.api.nvim_win_set_cursor(0, cursor)

  if test_name == nil then
    return false
  end

  run_jest("-t='" .. test_name .. "'")
  return true
end

function _G.jest_single()
  if jest_single_on_line() then
    return
  end

  local view = vim.fn.winsaveview()
  vim.api.nvim_command('silent exec "normal [M?func\\<CR>w*"')

  if not jest_single_on_line() then
    print('ERR: Could not find test name. Place cursor on line with test name.')
  end

  vim.fn.winrestview(view)
end

vim.cmd('command! JestFile :call v:lua.jest_file()')
vim.cmd('command! JestSingle :call v:lua.jest_single()')

