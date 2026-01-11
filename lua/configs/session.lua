require('auto-session').setup({
 auto_session_enable = true,
  auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/', 
  auto_session_suppress_dirs = { '~/', '~/Documents' }, 
  auto_session_enable_last_session = true, 
})    
  