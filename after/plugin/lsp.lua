require('mason').setup({})

vim.lsp.enable('lua_ls')
vim.lsp.enable('zls')

vim.lsp.set_log_level("trace")
vim.diagnostic.config({ virtual_lines = {current_line = true}})
