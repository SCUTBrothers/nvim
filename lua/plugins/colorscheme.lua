return {
  {
    "catppuccin/nvim",
    priority = 1000, -- Ensure it loads first
    opts = {
      transparent_background = true,
      no_italic = true, -- 禁用所有斜体
      styles = {
        comments = {}, -- 移除注释的斜体样式
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
