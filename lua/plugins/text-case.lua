return {
  "johmsalas/text-case.nvim",
  opts = {},
  keys = {
    { "\\c", "<cmd>lua require('textcase').current_word('to_camel_case')<cr>", mode = { "n", "v" }, desc = "to camelCase" },
    { "\\p", "<cmd>lua require('textcase').current_word('to_pascal_case')<cr>", mode = { "n", "v" }, desc = "to PascalCase" },
    { "\\s", "<cmd>lua require('textcase').current_word('to_snake_case')<cr>", mode = { "n", "v" }, desc = "to snake_case" },
    { "\\t", "<cmd>lua require('textcase').current_word('to_title_case')<cr>", mode = { "n", "v" }, desc = "to Title Case" },
    { "\\u", "<cmd>lua require('textcase').current_word('to_upper_case')<cr>", mode = { "n", "v" }, desc = "to UPPER_CASE" },
  },
}
