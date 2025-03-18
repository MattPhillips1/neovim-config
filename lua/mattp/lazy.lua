local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim", branch = '0.1.x',
    dependencies = {
      "nvim-lua/plenary.nvim" ,
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
         build = 'make',
        -- cond = function()
          -- return vim.fn.executable 'make' == 1
        -- end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
    }
  },
  { "rose-pine/neovim", name = "rose-pine" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "tpope/vim-fugitive" },
  { 'tpope/vim-rhubarb' },
  { 'lewis6991/gitsigns.nvim' },

	--- Uncomment these if you want to manage LSP servers from neovim
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp', dependencies = { 'L3MON4D3/LuaSnip' }},
	{'mfussenegger/nvim-jdtls'},
  {'mfussenegger/nvim-dap'},
  -- LSP Progress
  {'j-hui/fidget.nvim'},

  -- Notes
  {
    'vhyrro/luarocks.nvim',
    config = true, -- This automatically runs `require("luarocks-nvim").setup()
  },
  {
    'nvim-neorg/neorg',
    dependencies = { 'luarocks.nvim' },
  },

  -- File explorer
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  -- Copilot
  {'zbirenbaum/copilot.lua', cmd = 'Copilot', event = 'InsertEnter'},
  {'zbirenbaum/copilot-cmp', dependencies = {'zbirenbaum/copilot.lua'}},

})
