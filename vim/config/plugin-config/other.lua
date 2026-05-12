require("other-nvim").setup({
  showMissingFiles = false,
  rememberBuffers = false,
	mappings = {
    {
      pattern = "(.*).vue",
      target = {
        { target = "%1.story.js", context = "story" },
        { target = "%1.story.ts", context = "story" },
        { target = "%1.story.vue", context = "story" },
        { target = "%1.unit.js", context = "unit" },
        { target = "%1.unit.ts", context = "unit" },
        { target = "%1.test.js", context = "unit" },
        { target = "%1.test.ts", context = "unit" },
        { target = "%1.spec.js", context = "unit" },
        { target = "%1.spec.ts", context = "unit" },
      },
    },
    {
      pattern = "(.*).story.(?:js|ts|vue)",
      target = "%1.vue",
    },
    {
      pattern = "(.*).(?:unit|test|spec).[jt]s",
      target = {
        { target = "%1.vue" },
        { target = "%1.js" },
        { target = "%1.ts" },
      },
    },
    {
      pattern = "(.*)/([^.]*).[jt]s",
      target = {
        { target = "%1/%2.unit.js" },
        { target = "%1/%2.unit.ts" },
        { target = "%1/%2.test.js" },
        { target = "%1/%2.test.ts" },
        { target = "%1/%2.spec.js" },
        { target = "%1/%2.spec.ts" },
      },
    },
	},
})

vim.api.nvim_set_keymap("n", "<leader>aa", "<cmd>:Other<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>as", "<cmd>:OtherSplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>av", "<cmd>:OtherVSplit<CR>", { noremap = true, silent = true })
