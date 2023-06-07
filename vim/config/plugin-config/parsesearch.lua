-- TODO: turn this into a FZF plugin instead
local function parsesearch(opts)
  vim.fn.setqflist({}, ' ', { title = 'parsesearch results' })
  local escapedMatchStr = vim.fn.shellescape(opts.args):gsub('"', '\\"');
  vim.cmd('caddexpr system("parsesearch ' .. escapedMatchStr .. '")')
  vim.cmd('copen')
end

vim.api.nvim_create_user_command('Ps', parsesearch, { nargs = '?' })
