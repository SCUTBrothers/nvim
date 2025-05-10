return {
  "johmsalas/text-case.nvim",
  config = function()
    require("textcase").setup({})
  end,
  keys = {
    {
      "\\c",
      "<cmd>:lua require('textcase').current_word('to_camel_case')<cr>",
      mode = { "n", "v" },
      desc = "transform to camel case",
    },
    {
      "\\p",
      "<cmd>:lua require('textcase').current_word('to_pcasecal_case')<cr>",
      mode = { "n", "v" },
      desc = "transform to pascal case",
    },
    {
      "\\s",
      "<cmd>:lua require('textcase').current_word('to_snake_case')<cr>",
      mode = { "n", "v" },
      desc = "transform to snake case",
    },
    {
      "\\t",
      "<cmd>:lua require('textcase').current_word('to_title_case')<cr>",
      mode = { "n", "v" },
      desc = "transform to title case",
    },
    {
      "\\u",
      "<cmd>:lua require('textcase').current_word('to_upper_case')<cr>",
      mode = { "n", "v" },
      desc = "transform to upper case",
    },
  },
  lazy = false,
}
