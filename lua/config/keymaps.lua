-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- delete default keymaps
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")

-- 基础移动映射
map("n", "H", "^", { desc = "move to line start" })
map("n", "L", "$", { desc = "move to line start" })

-- buffer操作
map("n", "<S-j>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-k>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- 文件浏览
map("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- explorer
map("n", "<leader>yP", "<cmd>CopyAbsPath<cr>", { desc = "Copy relative file path" })
map("n", "<leader>yp", "<cmd>CopyRelPath<cr>", { desc = "Copy relative file path" })

local function copy_file_line_range()
  -- 获取当前文件的绝对路径
  local absolute_path = vim.fn.expand("%:p")
  -- 获取启动时的工作目录
  local cwd = vim.fn.getcwd()

  -- 计算相对路径
  local filepath = vim.fn.fnamemodify(absolute_path, ":.")

  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  local result
  if start_line == end_line then
    result = string.format("%s#L%d", filepath, start_line)
  else
    result = string.format("%s#L%d-%d", filepath, start_line, end_line)
  end

  vim.fn.setreg("+", result)
  print("已复制: " .. result)
end

-- 创建键映射
vim.keymap.set("v", "<leader>yp", copy_file_line_range, {
  desc = "复制相对于cwd的路径和行范围",
})

-- terminal
vim.keymap.del("n", "<leader>ft")
map("n", "<leader>ft", function()
  require("snacks").terminal(nil, { cwd = vim.fn.expand("%:p:h") })
end, { desc = "Terminal (Dir of Current File)" })

-- lsp
map("n", "cd", vim.lsp.buf.rename, { desc = "LSP Rename" })
