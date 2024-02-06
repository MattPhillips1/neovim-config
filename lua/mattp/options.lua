vim.api.nvim_set_option('rnu', true)
vim.api.nvim_set_option('expandtab', true)
vim.api.nvim_set_option('tabstop', 2)
vim.api.nvim_set_option('softtabstop', 2)
vim.api.nvim_set_option('shiftwidth', 2)

vim.api.nvim_set_hl(0, 'rust', { fg = '#B7410E' })
vim.api.nvim_set_option('statusline', '%<%f%=%h%m%r%#rust#%{FugitiveStatusline()}%*%=%-14.(%l,%c%V%)\\ %P')
