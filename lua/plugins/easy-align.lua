return {
  "junegunn/vim-easy-align",
  event = "VeryLazy",
  keys = {
    -- Start interactive EasyAlign in visual mode (e.g. vip<leader>a)
    {
      "gl",
      "<Plug>(EasyAlign)",
      mode = "x",
      desc = "EasyAlign (visual mode)",
    },
    -- Start interactive EasyAlign for a motion/text object (e.g. <leader>aip)
    {
      "gl",
      "<Plug>(EasyAlign)",
      mode = "n",
      desc = "EasyAlign (normal mode)",
    },
  },
  config = function()
    -- 自定义分隔符
    vim.g.easy_align_delimiters = {
      -- 等号对齐
      ["="] = {
        pattern = "=",
        left_margin = 1,
        right_margin = 1,
        stick_to_left = 0,
      },
      -- 冒号对齐 (JSON, CSS等)
      [":"] = {
        pattern = ":",
        left_margin = 0,
        right_margin = 1,
        stick_to_left = 1,
      },
      -- 箭头函数对齐
      [">"] = {
        pattern = "=>",
        left_margin = 1,
        right_margin = 1,
        stick_to_left = 0,
      },
      -- 竖线对齐 (Markdown表格)
      ["|"] = {
        pattern = "|",
        left_margin = 1,
        right_margin = 1,
        stick_to_left = 0,
      },
      -- 注释对齐
      ["/"] = {
        pattern = "//",
        left_margin = 1,
        right_margin = 0,
        stick_to_left = 0,
      },
      -- Hash/字典对齐
      ["#"] = {
        pattern = "#",
        left_margin = 1,
        right_margin = 1,
        stick_to_left = 0,
      },
      -- 逗号对齐
      [","] = {
        pattern = ",",
        left_margin = 0,
        right_margin = 1,
        stick_to_left = 1,
      },
    }
  end,
}
