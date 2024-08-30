require('onedark').setup  {
  style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = false,  -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- toggle theme style ---
  toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
  code_style = {
      comments = 'none',
      keywords = 'none',
      functions = 'none',
      strings = 'none',
      variables = 'none'
  },

  -- Lualine options --
  lualine = {
      transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  colors = {
    bright_orange = "#ff8800",
    green = '#98c379',  
    yellow = '#61afef',
    blue = '#61afef',
    blue_light = '#98c379',
  },
  highlights = {
    -- ["@string"] = {fg = '$blue_light', bg = 'None', fmt = 'bold'},
    ["@string"] = {fg = '$blue_light', bg = 'None'},
    ["@keyword"] = {fg = '#c678dd', bg = 'None'},
    ["@variable"] = {fg = '#e06c75', bg = 'None'},
    ["@type"] = {fg = '#e5c07b', bg = 'None'},
  },
  -- Plugins Config --
  diagnostics = {
      darker = true, -- darker colors for diagnostic
      undercurl = true,   -- use undercurl instead of underline for diagnostics
      background = true,    -- use background color for virtual text
  },
}

require('onedark').load()

vim.cmd("highlight Normal guibg=#23272e")
vim.cmd("highlight Function guifg=#0087d2")
vim.cmd("highlight Type guifg=#de935f")
vim.cmd("highlight Comment guifg=#7f9f7f")
vim.cmd("highlight String guifg=#98c379")
vim.cmd("highlight Number guifg=#d19a66")

vim.cmd("highlight Identifier guifg=#ff0000")
vim.cmd("highlight Keyword guifg=#ff0000")
vim.cmd("highlight Operator guifg=#ff0000")
vim.cmd("highlight PreProc guifg=#ff0000")
vim.cmd("highlight Class guifg=#FF5C5C")
vim.cmd("highlight CClass guifg=#FF5C5C")
vim.cmd("highlight CPPClass guifg=#FF5C5C")
vim.cmd("highlight CppClass guifg=#FF5C5C")
