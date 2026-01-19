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

-- 禁用 conceal 功能(vim.opt.conceallevel = 0)，防止 markdown 预览
vim.opt.conceallevel = 2

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

-- 启动 nvim server，供外部工具调用（如 code-inspector-plugin）
-- 根据项目目录生成唯一 socket 路径，支持多项目并行开发
local function find_project_root()
  local markers = { ".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml", "pom.xml" }
  local cwd = vim.fn.getcwd()

  -- 从当前目录向上查找项目标记
  local dir = cwd
  while dir ~= "/" do
    for _, marker in ipairs(markers) do
      if vim.fn.isdirectory(dir .. "/" .. marker) == 1 or vim.fn.filereadable(dir .. "/" .. marker) == 1 then
        return dir
      end
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return cwd
end

local function get_nvim_socket_path()
  local project_dir = find_project_root()
  -- 使用 md5 hash 避免路径过长（Unix socket 限制约 104 字符）
  local hash = vim.fn.sha256(project_dir):sub(1, 16)
  return "/tmp/nvim-" .. hash .. ".sock"
end

local socket_path = get_nvim_socket_path()
pcall(vim.fn.serverstart, socket_path)
