-- Composition API helper stuff

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>xa', '/export default<cr>ct{const a = <esc>', opts)
vim.api.nvim_set_keymap('n', '<leader>xc', '^iconst <c-o>f( = computed(<c-o>f{=> <esc>l%lr)j', opts)
vim.api.nvim_set_keymap('n', '<leader>xm', '$Bifunction <esc>$%lr;j', opts)
vim.api.nvim_set_keymap('n', '<leader>xv', 'yiw:%s/this.<c-r>0\\>/<c-r>0.value/g<cr><c-o>', opts)
vim.api.nvim_set_keymap('n', '<leader>xp', 'yiw:%s/this.<c-r>0\\>/props.<c-r>0/g<cr><c-o>j', opts)
vim.api.nvim_set_keymap('n', '<leader>xis', 'ggoimport { useStore } from \'vuex\';<esc><c-o>oconst store = useStore();<esc>:%s/this.\\$store/store/g<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>xir', 'ggoimport { useRouter } from \'vue-router\';<esc><c-o>oconst router = useRouter();<esc>:%s/this.\\$router/router/g<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>xit', 'ggoimport { useI18n } from \'vue-i18n\';<esc><c-o>oconst { t } = useI18n();<esc>:%s/this.\\$t/t/g<cr>', opts)

    -- isBookmarked() {
    --   if (this.controlBookmarksByControlID[this.control.controlID])
    --     return this.controlBookmarksByControlID[this.control.controlID]!.bookmarked;
    --   return false;
    -- },
