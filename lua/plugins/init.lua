return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   lazy = false,
  --   --event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     require "configs.lspconfig"
  --   end,
  -- },
  {
    "vim-scripts/a.vim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.api.nvim_del_keymap("n", "<Space>ihn")
        vim.api.nvim_del_keymap("n", "<Space>is")
        vim.api.nvim_del_keymap("n", "<Space>ih")
        vim.api.nvim_del_keymap("i", "<Space>ihn")
        vim.api.nvim_del_keymap("i", "<Space>is")
        vim.api.nvim_del_keymap("i", "<Space>ih")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "Nemausa/friendly-snippets",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "preservim/tagbar",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('Comment').setup()
    end
  },
  {
    "neoclide/coc.nvim", 
    branch = "release", 
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    'sbdchd/neoformat',
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    'sheerun/vim-polyglot',
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "iamcco/markdown-preview.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "mfussenegger/nvim-dap",
    lazy = false,
  },
  {
    "nvim-neotest/nvim-nio",
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap-python",
    lazy = false,
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function()
      require "configs.dap_config"
      require "configs.dap_cpp"
    end,
  },
  { "neovim/nvim-lspconfig", enabled = false }, -- 禁用 LSP
  { "hrsh7th/nvim-cmp", enabled = false },      -- 禁用 nvim-cmp
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
