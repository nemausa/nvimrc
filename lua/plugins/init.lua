return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },
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
--   {
--     "Nemausa/friendly-snippets",
--     event = { "BufReadPre", "BufNewFile" },
--   },
  {
    "preservim/tagbar",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "junegunn/fzf",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "liuchengxu/vista.vim",
    config = function()
      vim.g.vista_default_executive = "ctags"
      vim.keymap.set(
        "n",
        "<leader>vi",
        ":Vista!!<CR>",
        { noremap = true, silent = true, desc = "Open/Close vista and rotate window layout" }
      )
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "stevearc/aerial.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.aerial"
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('Comment').setup()
    end
  },
  {
    'sbdchd/neoformat',
    event = { "BufReadPre", "BufNewFile" },
  },
  -- {
  --   "neoclide/coc.nvim", 
  --   branch = "release", 
  --   event = { "BufReadPre", "BufNewFile" },
  -- },
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
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "nvim-neotest/nvim-nio",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "mfussenegger/nvim-dap-python",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.dap_python"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.dap_config"
      require "configs.dap_cpp"
    end,
  },
  { "neovim/nvim-lspconfig", enabled = true },
  { "hrsh7th/nvim-cmp", enabled = true },
  {
    "dart-lang/dart-vim-plugin",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
  {
    "vim-scripts/a.vim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.session"
    end,
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
