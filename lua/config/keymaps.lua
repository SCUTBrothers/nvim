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
-- 跳转到当前函数的 return 语句
-- 支持所有有 treesitter parser 的语言
-- ============================================================================
local function goto_return_statement()
  local bufnr = vim.api.nvim_get_current_buf()

  -- 获取当前 buffer 的 treesitter parser
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then
    vim.notify("No treesitter parser for this file", vim.log.levels.WARN)
    return
  end

  local lang = parser:lang()
  local tree = parser:parse()[1]
  if not tree then
    return
  end

  -- 获取光标位置的节点
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_row, cursor_col = cursor[1] - 1, cursor[2]
  local cursor_node = tree:root():named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)

  if not cursor_node then
    return
  end

  -- 不同语言的函数节点类型
  local function_types = {
    -- JavaScript/TypeScript
    "function_declaration",
    "function_expression",
    "arrow_function",
    "method_definition",
    -- Lua
    "function_declaration",
    "function_definition",
    -- Python
    "function_definition",
    -- Go
    "function_declaration",
    "method_declaration",
    -- Rust
    "function_item",
    -- C/C++
    "function_definition",
  }

  -- 查找包含光标的函数节点
  local function_node = cursor_node
  while function_node do
    if vim.tbl_contains(function_types, function_node:type()) then
      break
    end
    function_node = function_node:parent()
  end

  if not function_node then
    vim.notify("Not inside a function", vim.log.levels.WARN)
    return
  end

  -- 在函数节点中查找所有 return 语句
  local return_nodes = {}
  local query_string = "(return_statement) @return"

  local query_ok, query = pcall(vim.treesitter.query.parse, lang, query_string)
  if not query_ok then
    vim.notify("No return_statement query for this language", vim.log.levels.WARN)
    return
  end

  for id, node in query:iter_captures(function_node, bufnr) do
    -- 确保 return 语句直接属于当前函数（不是嵌套函数中的）
    local parent = node:parent()
    local is_nested = false
    while parent and parent ~= function_node do
      if vim.tbl_contains(function_types, parent:type()) then
        is_nested = true
        break
      end
      parent = parent:parent()
    end
    if not is_nested then
      table.insert(return_nodes, node)
    end
  end

  if #return_nodes == 0 then
    vim.notify("No return statement found in this function", vim.log.levels.INFO)
    return
  end

  -- 跳转到下一个 return 语句，如果已在最后一个则循环到第一个
  local target_node = return_nodes[1]

  for i, node in ipairs(return_nodes) do
    local start_row = node:start()
    if start_row > cursor_row then
      target_node = node
      break
    elseif i == #return_nodes then
      target_node = return_nodes[1]
    end
  end

  local start_row, start_col = target_node:start()
  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
end

map("n", "gq", goto_return_statement, { desc = "Go to return statement" })

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
