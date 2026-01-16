-- 检测 macOS 系统主题
local function is_dark_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result:match("Dark") ~= nil
  end
  return true -- 默认深色
end

-- 根据环境选择主题
local function get_colorscheme()
  local in_vscode = vim.env.TERM_PROGRAM == "vscode"
  if in_vscode then
    -- 在 VSCode 终端中，根据系统主题选择
    return is_dark_mode() and "catppuccin-mocha" or "catppuccin-latte"
  end
  return "catppuccin" -- 默认使用 catppuccin（mocha）
end

return {
  {
    "catppuccin/nvim",
    priority = 1000, -- Ensure it loads first
    opts = {
      -- !如果transparent_background设置为true, 在浅色背景下, fzf find files弹窗背景可能会是黑色
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
      colorscheme = get_colorscheme(),
    },
  },
}
