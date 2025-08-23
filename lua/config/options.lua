-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Fix XDG_RUNTIME_DIR for WSL
if vim.fn.has("wsl") == 1 then
  local uid = vim.fn.system("id -u"):gsub("%s+", "")
  local runtime_dir = "/tmp/nvim-runtime-" .. uid
  vim.fn.system("mkdir -p " .. runtime_dir)
  vim.env.XDG_RUNTIME_DIR = runtime_dir
end

vim.opt.list = false
vim.opt.relativenumber = true

-- 根据环境变量设置背景色
-- local theme_mode = vim.env.THEME_MODE or "dark" -- 默认深色主题
-- vim.opt.background = theme_mode

-- 禁用光标下单词的高亮
vim.opt.hlsearch = false -- 禁用搜索高亮

-- 禁用 conceal 功能，防止 markdown 预览
vim.opt.conceallevel = 0

-- 将-添加为word分隔符
vim.opt.iskeyword:append("-")

-- ~/.config/nvim/lua/config/options.lua 或 init.lua
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

-- 启用系统剪贴板
vim.opt.clipboard = "unnamedplus"

vim.opt.autoread = true
