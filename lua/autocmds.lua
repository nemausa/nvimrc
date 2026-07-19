function SetTab2()
  vim.o.shiftwidth   = 2
  vim.o.tabstop      = 2
  vim.o.softtabstop  = 2
  vim.o.expandtab    = true
  print("Tab size set to 2")
end

function SetTab4()
  vim.o.shiftwidth   = 4
  vim.o.tabstop      = 4
  vim.o.softtabstop  = 4
  vim.o.expandtab    = true
  print("Tab size set to 4")
end

function ToggleTabSize()
  if vim.bo.tabstop == 4 then
    SetTab2()
  else
    SetTab4()
  end
end

vim.keymap.set("n", "<leader>st", ToggleTabSize, { noremap = true, silent = true,desc = "ToggleTabSize 2 or 4"  } )
vim.keymap.set("n", "<leader>t2", SetTab2, { noremap = true, silent = true , desc = "Tab size set to 2"} )
vim.keymap.set("n", "<leader>t4", SetTab4, { noremap = true, silent = true , desc = "Tab size set to 4"} )

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost" }, {
  group = vim.api.nvim_create_augroup("autosave_on_focus_change", { clear = true }),
  callback = function(args)
    local bufnr = args.buf ~= 0 and args.buf or vim.api.nvim_get_current_buf()
    local buffer_options = vim.bo[bufnr]

    if buffer_options.buftype == ""
      and buffer_options.modifiable
      and buffer_options.modified
      and vim.api.nvim_buf_get_name(bufnr) ~= ""
    then
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd "silent! update"
      end)
    end
  end,
})

vim.cmd("autocmd FileType c,cpp setlocal commentstring=//\\ %s")

vim.g.tagbar_type_c = {
  kinds = {
    "f:functions",
    "e:enums",
    "s:structs",
  },
  sro = "::",
  kind2scope = {
    e = "enum",
    s = "struct",
  },
  scope2kind = {
    enum = "e",
    struct = "s",
  },
}
