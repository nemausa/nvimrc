return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local previous_on_attach = opts.on_attach

      opts.on_attach = function(bufnr)
        if previous_on_attach then
          previous_on_attach(bufnr)
        end

        local gitsigns = require "gitsigns"
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end, "Git next hunk")

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end, "Git previous hunk")

        map("n", "<leader>hp", gitsigns.preview_hunk, "Git preview hunk")
        map("n", "<leader>hs", gitsigns.stage_hunk, "Git stage hunk")
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Git undo stage hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Git reset hunk")
        map("n", "<leader>hb", function()
          gitsigns.blame_line { full = true }
        end, "Git blame line")
      end

      return opts
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git file history" },
      { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Git close diff view" },
    },
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
