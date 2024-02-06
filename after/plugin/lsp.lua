local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
  vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, {buffer=bufnr})
  vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, {buffer=bufnr})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {buffer=bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'jdtls', 'rust_analyzer', 'lua_ls', 'terraformls'},
  handlers = {
    lsp_zero.default_setup,
    jdtls = lsp_zero.noop,
  }
})

vim.lsp.set_log_level("trace")
