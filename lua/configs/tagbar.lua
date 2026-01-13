-- Tagbar configuration.
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