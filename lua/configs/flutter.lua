require("flutter-tools").setup{
  lsp = {
    on_attach = function(client, bufnr)
      require("lsp-status").on_attach(client)
    end
  },
}
