vim.api.nvim_create_autocmd('FileType', {
  pattern = { 
    'java',
    'zig',
  },
  callback = vim.treesitter.start,
})
