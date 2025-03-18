require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["<C-q>"] = {
      "actions.send_to_qflist",
      mode = "n",
    },
  },
})

vim.keymap.set("n", "<leader>pv", require("oil").open)
