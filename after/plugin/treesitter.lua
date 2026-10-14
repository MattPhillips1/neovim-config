vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'java',
    'zig',
    'lua',
  },
  callback = function() vim.treesitter.start() end,
})
