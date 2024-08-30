require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})

require('diffview').setup({
    file_panel = {
        listing_style = 'tree', -- tree or list
    },
    enhanced_diff_hl = true,
})
