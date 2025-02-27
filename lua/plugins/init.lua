return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "vim-scripts/a.vim",
    lazy = false,
    -- config = function()
    --   require "configs.autocmds"
    -- end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
  },
  {
    "Nemausa/friendly-snippets",
    lazy = false,
  },
  {
    "preservim/tagbar",
    lazy = false,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require('Comment').setup()
    end
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
