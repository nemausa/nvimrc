local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local f  = ls.function_node

-- 将文件名转为全大写宏（去掉扩展名）
local function filename_macro(_, _)
  local name = vim.fn.expand("%:t:r")  -- 当前文件名（不带扩展名）
  return name:upper() .. "_H_"
end

return {
  s("header", {
    t({"/**",
       " * @file "}), 
    f(function() return vim.fn.expand("%:t") end, {}),
    t({"",
       " *",
       " * @brief This message displayed in Doxygen Files index",
       " *",
       " * @ingroup PackageName",
       " * (note: this needs exactly one @defgroup somewhere)",
       " *",
       " * @author Nemausa",
       " */",
       "",
       "#ifndef "}),
    f(filename_macro, {}),
    t({"",
       "#define "}),
    f(filename_macro, {}),
    t({"", ""}),
    i(0),
    t({"", "", "#endif  // "}),
    f(filename_macro, {}),
  }),
}
 