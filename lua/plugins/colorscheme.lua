return {
  -- Gruvbox (深色主题)
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

  -- Catppuccin Latte (浅色主题)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      no_italic = true,
      styles = {
        comments = {},
      },
    },
  },

  -- 根据 background 自动切换主题 (Neovim 0.11+ Mode 2031)
  {
    "LazyVim/LazyVim",
    opts = function()
      -- 根据初始 background 设置主题
      local colorscheme = vim.o.background == "light" and "catppuccin-latte" or "gruvbox"

      -- 监听 background 变化，自动切换主题
      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = function()
          if vim.o.background == "light" then
            vim.cmd("colorscheme catppuccin-latte")
          else
            vim.cmd("colorscheme gruvbox")
          end
        end,
      })

      return { colorscheme = colorscheme }
    end,
  },
}
