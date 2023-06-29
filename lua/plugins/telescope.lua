return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      initial_mode = "insert",

      mappings = {
        i = {
          -- 上下移动
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<Down>"] = "move_selection_next",
          ["<Up>"] = "move_selection_previous",
          -- 历史记录
          ["<C-n>"] = "cycle_history_next",
          ["<C-p>"] = "cycle_history_prev",
          -- 关闭窗口
          ["<C-c>"] = "close",
          -- 预览窗口上下滚动
          ["<C-u>"] = "preview_scrolling_up",
          ["<C-d>"] = "preview_scrolling_down",
        },
      },
    },
  },
}
