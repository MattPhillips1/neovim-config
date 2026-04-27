vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'zig' },
  callback = function() vim.treesitter.start() end,
})
