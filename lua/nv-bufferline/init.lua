require'bufferline'.setup{
options = {
  tab_size = 28,
  close_icon ="",
  indicator_icon = '▎',
  left_trunc_marker = '',
  right_trunc_marker = '',
}
}
vim.api.nvim_set_keymap('n', '<TAB>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })