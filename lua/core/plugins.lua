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
  "navarasu/onedark.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-tree/nvim-tree.lua",
  "nvim-lualine/lualine.nvim",
  "akinsho/bufferline.nvim",
  { "nvim-treesitter/nvim-treesitter", lazy = false },
  "sheerun/vim-polyglot",
  "vim-scripts/a.vim",
  "kyazdani42/nvim-web-devicons",
  "L3MON4D3/LuaSnip",
  "Nemausa/friendly-snippets",
  "tpope/vim-fugitive",
  "nvim-lua/plenary.nvim",
  "sindrets/diffview.nvim",
  "lewis6991/gitsigns.nvim",
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-dap-python",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-neotest/nvim-nio",
  "danymat/neogen",
  "stevearc/aerial.nvim",
  "preservim/tagbar",
  "norcalli/nvim-colorizer.lua",
  "tpope/vim-abolish",
  { "neoclide/coc.nvim", branch = "release" },
  "iamcco/markdown-preview.nvim",
  "akinsho/toggleterm.nvim",
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({})
    end,
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  "windwp/nvim-spectre",
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  },
  -- "nvim-pack/nvim-spectre",
  "windwp/nvim-spectre",
  {
    "folke/which-key.nvim",
    lazy = false,
  },
})
