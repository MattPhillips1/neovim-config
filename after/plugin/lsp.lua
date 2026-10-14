require('mason').setup({})

vim.lsp.enable('lua_ls')
vim.lsp.enable('zls')

vim.diagnostic.config({ virtual_lines = {current_line = true}})
