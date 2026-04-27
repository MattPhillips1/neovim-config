vim.g.mapleader = " "
-- Auto match
vim.keymap.set("i", "{", "{}<LEFT>")
vim.keymap.set("i", "(", "()<LEFT>")
vim.keymap.set("i", "[", "[]<LEFT>")


local function current_date()
  vim.api.nvim_paste(os.date("%Y-%m-%d"), false, -1)
end

vim.keymap.set('n', '<leader>cd', current_date)
