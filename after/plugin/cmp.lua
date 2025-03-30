local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
   ['<CR>'] = cmp.mapping.confirm(),
  }),
  sources = cmp.config.sources({
    { name = 'copilot', group_index = 2 },
    { name = 'luasnip', group_index = 2},
    { name = 'nvim_lsp', group_index = 2},
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
