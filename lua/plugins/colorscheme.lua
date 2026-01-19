return {
  -- Gruvbox (当前使用)
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      transparent_mode = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Catppuccin (备用)
  -- {
  --   "catppuccin/nvim",
  --   priority = 1000,
  --   opts = {
  --     transparent_background = true,
  --     no_italic = true,
  --     styles = {
  --       comments = {},
  --     },
  --   },
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin",
  --   },
  -- },
}
