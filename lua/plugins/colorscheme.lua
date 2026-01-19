-- 检测 macOS 系统主题
local function get_system_colorscheme()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result:match("Dark") then
      return "gruvbox"
    end
  end
  return "catppuccin-latte"
end

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

  -- Catppuccin (浅色主题用 latte)
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

  -- 根据系统主题设置 colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = get_system_colorscheme(),
    },
  },
}
