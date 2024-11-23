require('bqf').setup({
  auto_enable = true,
  preview = {
    border = 'rounded',
    win_height = 15,
    win_vheight = 10,
    wrap = false
  },
  func_map = {
    open = '<CR>',
    drop = 'o',
    split = '<C-s>',
    vsplit = '<C-v>',
    tabdrop = '<C-t>',
    prevfile = '<C-p>',
    nextfile = '<C-n>'
  },
  filter = {
    fzf = {
      action_for = {['ctrl-s'] = 'split'},
      extra_opts = {'--bind', 'ctrl-o:toggle-all'}
    }
  }
})
