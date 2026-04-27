vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'java',
    'zig',
  },
  callback = function() vim.treesitter.start() end,
})
