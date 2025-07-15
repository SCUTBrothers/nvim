-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- delete default keymaps
vim.keymap.del({ "i", "n", "v" }, "<A-j>")
vim.keymap.del({ "i", "n", "v" }, "<A-k>")

-- 基础移动映射
map("n", "H", "^", { desc = "move to line start" })
map("n", "L", "$", { desc = "move to line start" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })

-- buffer操作
map("n", "<S-j>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-k>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- 文件浏览
map("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- explorer
map("n", "<leader>yP", "<cmd>CopyAbsPath<cr>", { desc = "Copy relative file path" })
map("n", "<leader>yp", "<cmd>CopyRelPath<cr>", { desc = "Copy relative file path" })
map("n", "<leader>yY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", "@" .. path)
  print("已复制: @" .. path)
end, { desc = "Copy absolute file path with @ prefix" })
map("n", "<leader>yy", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", "@" .. path)
  print("已复制: @" .. path)
end, { desc = "Copy relative file path with @ prefix" })

local function copy_file_line_range(with_prefix)
  -- 获取当前文件的绝对路径
  local absolute_path = vim.fn.expand("%:p")
  -- 获取启动时的工作目录

  -- 计算相对路径
  local filepath = vim.fn.fnamemodify(absolute_path, ":.")

  -- 获取实际的行号（使用 v 和 . 来获取当前选择）
  local start_line = vim.fn.getpos("v")[2]
  local end_line = vim.fn.getpos(".")[2]

  -- 确保 start_line 是较小的行号
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local prefix = with_prefix and "@" or ""
  local result
  if start_line == end_line then
    result = string.format("%s%s#L%d", prefix, filepath, start_line)
  else
    result = string.format("%s%s#L%d-%d", prefix, filepath, start_line, end_line)
  end

  vim.fn.setreg("+", result)
  print("已复制: " .. result)
end

-- 创建键映射
vim.keymap.set("v", "<leader>yp", function()
  copy_file_line_range(false)
end, {
  desc = "复制相对于cwd的路径和行范围",
})

vim.keymap.set("v", "<leader>yy", function()
  copy_file_line_range(true)
end, {
  desc = "复制相对于cwd的路径和行范围（带@前缀）",
})

-- terminal
vim.keymap.del("n", "<leader>ft")
map("n", "<leader>ft", function()
  require("snacks").terminal(nil, { cwd = vim.fn.expand("%:p:h") })
end, { desc = "Terminal (Dir of Current File)" })

-- lsp
map("n", "cd", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- Open current directory in IDE
map("n", "<leader>iv", function()
  vim.fn.system("code .")
end, { desc = "Open in VS Code" })

map("n", "<leader>iw", function()
  vim.fn.system("webstorm .")
end, { desc = "Open in WebStorm" })
