return {
  {
    "catppuccin/nvim",
    priority = 1000, -- Ensure it loads first
    opts = {
      -- !如果transparent_background设置为true, 在浅色背景下, fzf find files弹窗背景可能会是黑色
      transparent_background = true,
      no_italic = true, -- 禁用所有斜体
      styles = {
        comments = {},  -- 移除注释的斜体样式
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
