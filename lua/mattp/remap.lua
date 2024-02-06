vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Auto match
vim.keymap.set("i", "{", "{}<LEFT>")
vim.keymap.set("i", "(", "()<LEFT>")
vim.keymap.set("i", "[", "[]<LEFT>")
