vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank({ timeout = 100 }) end })
