return {
  -- flash-zh.nvim: 支持小鹤双拼中文跳转
  {
    "rainzm/flash-zh.nvim",
    dependencies = "folke/flash.nvim",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash-zh").jump({
            chinese_only = false,
          })
        end,
        desc = "Flash 跳转 (支持中英文)",
      },
    },
  },

  -- flash.nvim 基础配置
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          -- 保留原生 f/F/t/T 行为，不被 flash 接管
          enabled = true,
        },
      },
    },
  },
}
