require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'jdtls', 'rust_analyzer', 'lua_ls', 'starpls', 'terraformls', 'zls'},
})

local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  settings = {
    ['rust-analyzer'] = {
      completion = {
        postfix = {
          enable = false,
        },
      },
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
})

lspconfig.lua_ls.setup({})
lspconfig.starpls.setup({
  filetypes = {'bzl', 'starlark'}
})
lspconfig.terraformls.setup({})

lspconfig.zls.setup {
  -- Server-specific settings. See `:help lspconfig-setup`

  -- omit the following line if `zls` is in your PATH
  -- cmd = { '/path/to/zls_executable' },
  -- There are two ways to set config options:
  --   - edit your `zls.json` that applies to any editor that uses ZLS
  --   - set in-editor config options with the `settings` field below.
  --
  -- Further information on how to configure ZLS:
  -- https://zigtools.org/zls/configure/
  settings = {
    zls = {
      -- Whether to enable build-on-save diagnostics
      --
      -- Further information about build-on save:
      -- https://zigtools.org/zls/guides/build-on-save/
      enable_build_on_save = true,
      build_on_save_args = {"check", "--watch", "-fincremental" },

      -- Neovim already provides basic syntax highlighting
      semantic_tokens = "partial",

      -- omit the following line if `zig` is in your PATH
      -- zig_exe_path = '/path/to/zig_executable'
    }
  }
}

vim.lsp.set_log_level("trace")
vim.keymap.set('n', 'gri', require('telescope.builtin').lsp_implementations)
vim.keymap.set('n', 'grd', require('telescope.builtin').lsp_definitions)
vim.keymap.set('n', 'grr', require('telescope.builtin').lsp_references)

