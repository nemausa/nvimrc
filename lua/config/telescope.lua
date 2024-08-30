local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    file_ignore_patterns = { ".git/", "tags" },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,    
    },
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
      },
    },
  },
}

vim.api.nvim_create_user_command(
  'Ra',
  function(opts)
    local args = vim.split(opts.args, " ")
    local old_string = args[1]
    local new_string = args[2]
    local match_type = args[3]

    local search_pattern
    if match_type == "exact" then
      search_pattern = '\\V\\<' .. old_string .. '\\>'
    else
      search_pattern = old_string
    end

    vim.cmd('grep! ' .. old_string)
    vim.cmd('copen')
    vim.cmd('cdo s/' .. search_pattern .. '/' .. new_string .. '/g | update')
    vim.cmd('cclose')
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, true, true), 'n', false)
  end,
  { nargs = '+' }
)