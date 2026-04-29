local cmp = require 'cmp'

cmp.setup({
  completion = {
    -- autocomplete = false
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
  }),
	mapping = cmp.mapping.preset.insert({
    -- Your configuration here.
  }),
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
})

vim.api.nvim_set_keymap('', '<c-n>', '<cmd>lua require("cmp").complete()<CR>', { noremap = true })

-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   })
-- })

require "lsp_signature".setup({
  floating_window = false,
  hint_enable = true,
})

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Shared defaults for every server we enable below.
vim.lsp.config('*', {
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
})

-- glsl has no built-in nvim-lspconfig entry; declare it inline.
vim.lsp.config('glsl', {
  cmd = { 'glslls', '--stdin' },
  filetypes = { 'glsl' },
  root_markers = { '.git' },
})

-- These servers need the .git root for monorepos where package.json isn't accurate.
-- Linters (eslint, oxlint) are excluded so they keep their upstream root_markers
-- and only attach in projects that actually configure them.
local git_root_servers = { 'html', 'ts_ls', 'volar', 'glsl', 'lua_ls', 'bashls', 'sourcekit', 'graphql', 'phpactor', 'tailwindcss', 'gopls' }
for _, name in ipairs(git_root_servers) do
  vim.lsp.config(name, { root_markers = { '.git' } })
end

local npm_prefix = vim.fn.system('npm config get prefix'):gsub('[\n\r]', '')
vim.lsp.config('ts_ls', {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = npm_prefix .. '/lib/node_modules/@vue/typescript-plugin',
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

vim.lsp.config('graphql', {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'graphql' },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('gopls', {
  cmd = { vim.fn.expand('$HOME/go/bin/gopls') },
})

vim.lsp.enable({
  'eslint', 'oxlint', 'html', 'ts_ls', 'volar', 'glsl',
  'lua_ls', 'bashls', 'sourcekit', 'graphql', 'phpactor',
  'tailwindcss', 'gopls',
})
