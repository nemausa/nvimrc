require("neogen").setup {
  enabled = true,
  snippet_engine = "luasnip",
  languages = {
      cpp = {
          template = {
              annotation_convention = "doxygen"
          }
      },
      lua = {
          template = {
              annotation_convention = "emmylua"
          }
      }
  }
}