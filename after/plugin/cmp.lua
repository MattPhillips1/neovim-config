local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
   ['<CR>'] = cmp.mapping.confirm(),
  }),
  sources = cmp.config.sources({
    { name = 'cody' },
    { name = 'nvim_lsp' },
  }),
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  performance = {
    max_view_entries = 50,
  },
  experimental = {
    ghost_text = true,
  },
})
