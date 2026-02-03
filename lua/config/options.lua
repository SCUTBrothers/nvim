-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.list = false
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.conceallevel = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.autoread = true
vim.opt.iskeyword:append("-")

-- 禁用 copilot next edit suggestions
vim.g.copilot_nes = true

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
