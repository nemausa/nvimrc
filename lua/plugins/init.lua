return {
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedarkpro").setup {
        styles = {
          comments = "italic",
        },
        highlights = {
          -- A subtle red tint keeps column 100 visible without dominating code.
          ColorColumn = { bg = "#3b3239" },
          -- NvChad configures indent-blankline with these group names.
          IblChar = { fg = "${indentline}" },
          IblScopeChar = { fg = "${purple}" },
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- NvChad's parent opts load cached Base46 syntax groups here. Apply the
      -- code theme immediately afterward, before indent-blankline is loaded.
      vim.cmd.colorscheme "onedark"
      return opts
    end,
  },

  {
    "folke/which-key.nvim",
    enabled = false,
  },

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
    enabled = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
    opts = function()
      local actions = require "diffview.actions"

      return {
        keymaps = {
          file_panel = {
            { "n", "j", actions.select_next_entry, { desc = "Open diff for next file" } },
            { "n", "<down>", actions.select_next_entry, { desc = "Open diff for next file" } },
            { "n", "k", actions.select_prev_entry, { desc = "Open diff for previous file" } },
            { "n", "<up>", actions.select_prev_entry, { desc = "Open diff for previous file" } },
          },
        },
      }
    end,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff view" },
      {
        "<leader>gh",
        function()
          local actions = require "telescope.actions"
          local action_state = require "telescope.actions.state"

          require("telescope.builtin").git_commits {
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                if not entry then
                  return
                end

                actions.close(prompt_bufnr)

                local diffview_config = require("diffview.config").get_config()
                local original_listing_style = diffview_config.file_panel.listing_style
                local original_win_config = diffview_config.file_panel.win_config

                diffview_config.file_panel.listing_style = "list"
                diffview_config.file_panel.win_config = vim.tbl_extend("force", {}, original_win_config, {
                  width = 40,
                })

                local ok, err = pcall(vim.cmd, "DiffviewOpen " .. entry.value .. "^!")

                diffview_config.file_panel.listing_style = original_listing_style
                diffview_config.file_panel.win_config = original_win_config

                if not ok then
                  error(err)
                end
              end)
              return true
            end,
          }
        end,
        desc = "Git commit history",
      },
      { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Git close diff view" },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    opts = {
      enabledEngines = { "ripgrep" },
      windowCreationCommand = 'topleft vsplit | execute "vertical resize " . float2nr(&columns * 0.3) | setlocal winfixwidth',
      startInInsertMode = true,
      openTargetWindow = {
        preferredLocation = "right",
        useScratchBuffer = true,
      },
      keymaps = {
        openNextLocation = { n = "j" },
        openPrevLocation = { n = "k" },
        gotoLocation = { n = "<enter>" },
      },
      engines = {
        ripgrep = {
          path = "rg",
          defaults = {
            flags = "--fixed-strings --ignore-case",
          },
        },
      },
    },
    keys = {
      {
        "<leader>fr",
        function()
          require("grug-far").open()
        end,
        mode = "n",
        desc = "Workspace search and replace",
      },
      {
        "<leader>fr",
        function()
          require("grug-far").with_visual_selection()
        end,
        mode = "x",
        desc = "Workspace search selected text",
      },
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
