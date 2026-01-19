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
map("n", "yL", "yg_", { desc = "move to line end" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })

-- buffer操作
map("n", "<S-j>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-k>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- ============================================================================
-- 路径复制（与 VSCode 插件保持一致）
-- ============================================================================
-- 文件路径
map("n", "<leader>yy", "<cmd>CopyFileRelative<cr>", { desc = "Copy file relative path" })
map("n", "<leader>ya", "<cmd>CopyFileAbsolute<cr>", { desc = "Copy file absolute path" })
-- 工作区
map("n", "<leader>yw", "<cmd>CopyWorkspaceRoot<cr>", { desc = "Copy workspace root path" })
-- 文件夹路径
map("n", "<leader>yfy", "<cmd>CopyFolderRelative<cr>", { desc = "Copy folder relative path" })
map("n", "<leader>yfa", "<cmd>CopyFolderAbsolute<cr>", { desc = "Copy folder absolute path" })

-- Visual 模式（带行号）
map("v", "<leader>yy", "<cmd>CopyFileRelative<cr>", { desc = "Copy file relative path with line numbers" })
map("v", "<leader>ya", "<cmd>CopyFileAbsolute<cr>", { desc = "Copy file absolute path with line numbers" })

-- terminal
vim.keymap.del("n", "<leader>ft")
map("n", "<leader>ft", function()
  require("snacks").terminal(nil, { cwd = vim.fn.expand("%:p:h") })
end, { desc = "Terminal (Dir of Current File)" })

-- lsp
map("n", "cd", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- ============================================================================
-- 外部编辑器配置
-- ============================================================================
-- 可用编辑器: "code" (VS Code), "cursor" (Cursor)
vim.g.external_editor = "code"

local function open_in_editor(editor)
  editor = editor or vim.g.external_editor
  local file = vim.api.nvim_buf_get_name(0)

  if file == "" then
    vim.notify("No file for current buffer", vim.log.levels.WARN)
    return
  end

  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local target = string.format("%s:%d:%d", file, line, col)

  vim.fn.jobstart({ editor, "--reuse-window", "--goto", target }, { detach = true })
end

-- 用户命令
vim.api.nvim_create_user_command("EditorHere", function()
  open_in_editor()
end, {})
vim.api.nvim_create_user_command("EditorSet", function(opts)
  vim.g.external_editor = opts.args
  vim.notify("External editor set to: " .. opts.args, vim.log.levels.INFO)
end, {
  nargs = 1,
  complete = function()
    return { "code", "cursor" }
  end,
})

-- 快捷键
map("n", "<leader>io", function()
  open_in_editor()
end, { desc = "Open file in external editor" })
map("n", "<leader>iv", function()
  open_in_editor("code")
end, { desc = "Open file in VS Code" })
map("n", "<leader>ic", function()
  open_in_editor("cursor")
end, { desc = "Open file in Cursor" })
