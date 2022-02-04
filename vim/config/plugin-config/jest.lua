-- Based on kubejm/jest.nvim, but copies to clipboard
local function get_current_file_path()
  return vim.fn.getreg('%')
end

local function run_jest(args)
  local cmd = vim.g.jest_cmd or 'npx jest'
  local t = {}
  table.insert(t, cmd)

  if args ~= nil then
    for _, v in pairs(args) do
      table.insert(t, v)
    end
  end

  vim.fn.setreg('+', table.concat(t, ' '))
end

function _G.jest_file()
  local c_file = get_current_file_path()

  local args = {}
  table.insert(args, '--runTestsByPath ' .. c_file)
  run_jest(args)
end

function _G.jest_single()
  local c_file = get_current_file_path()
  local line = vim.api.nvim_get_current_line()

  local _, _, test_name = string.find(line, "^%s*%a+%(['\"](.+)['\"]")

  if test_name ~= nil then
    local args = {}
    table.insert(args, '--runTestsByPath ' .. c_file)
    table.insert(args, "-t='" .. test_name .. "'")
    run_jest(args)
  else
    print('ERR: Could not find test name. Place cursor on line with test name.')
  end
end

vim.cmd('command! JestFile :call v:lua.jest_file()')
vim.cmd('command! JestSingle :call v:lua.jest_single()')

