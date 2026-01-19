-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ============================================================================
-- 主题自动切换 (Neovim 0.11+ Mode 2031)
-- 深色: gruvbox, 浅色: catppuccin-latte
-- 参考: https://github.com/neovim/neovim/issues/32109
-- ============================================================================
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local switching = false
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = function()
        if switching then
          return
        end
        switching = true
        vim.schedule(function()
          local target = vim.o.background == "light" and "catppuccin-latte" or "gruvbox"
          -- 只有当前主题不是目标主题时才切换，防止递归
          if vim.g.colors_name ~= target then
            pcall(vim.cmd.colorscheme, target)
          end
          switching = false
        end)
      end,
    })
  end,
})

-- ============================================================================
-- 路径复制功能（与 VSCode 插件保持一致）
-- ============================================================================

-- 获取行号后缀
local function get_line_suffix()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    local start_line = vim.fn.getpos("v")[2]
    local end_line = vim.fn.getpos(".")[2]
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    return string.format("#L%d-%d", start_line, end_line)
  end
  return ""
end

-- my.copy.file.relative - 文件相对路径（相对于 cwd）
vim.api.nvim_create_user_command("CopyFileRelative", function()
  local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  local suffix = get_line_suffix()
  local result = path .. suffix
  vim.fn.setreg("+", result)
  print("已复制: " .. result)
end, {})

-- my.copy.file.absolute - 文件绝对路径
vim.api.nvim_create_user_command("CopyFileAbsolute", function()
  local path = vim.fn.expand("%:p")
  local suffix = get_line_suffix()
  local result = path .. suffix
  vim.fn.setreg("+", result)
  print("已复制: " .. result)
end, {})

-- my.copy.workspace.root - 工作区根目录绝对路径
vim.api.nvim_create_user_command("CopyWorkspaceRoot", function()
  local path = vim.fn.getcwd()
  vim.fn.setreg("+", path)
  print("已复制: " .. path)
end, {})

-- my.copy.folder.relative - 文件夹相对路径
vim.api.nvim_create_user_command("CopyFolderRelative", function()
  local path = vim.fn.fnamemodify(vim.fn.expand("%:h"), ":.")
  if path == "" then
    path = "."
  end
  vim.fn.setreg("+", path)
  print("已复制: " .. path)
end, {})

-- my.copy.folder.absolute - 文件夹绝对路径
vim.api.nvim_create_user_command("CopyFolderAbsolute", function()
  local path = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", path)
  print("已复制: " .. path)
end, {})

-- 创建自动命令组
local im_select_group = vim.api.nvim_create_augroup("im_select", { clear = true })

-- 在退出插入模式时切换到英文输入法
vim.api.nvim_create_autocmd("InsertLeave", {
  group = im_select_group,
  callback = function()
    -- 设置按键序列的超时时间（毫秒）: 当你输入一个可能是映射开头的按键时，Vim 会等待 timeoutlen 毫秒来判断你是否要输入一个完整的按键映射
    -- 这个可能会导致其他的remap映射失效
    -- vim.opt.timeoutlen = 0
    vim.fn.system("/opt/homebrew/bin/macism com.apple.keylayout.ABC")
  end,
})

-- 保存上一次的输入法状态
local last_im_select = ""

-- 在退出插入模式时保存当前输入法状态
vim.api.nvim_create_autocmd("InsertLeave", {
  group = im_select_group,
  callback = function()
    last_im_select = vim.fn.system("/opt/homebrew/bin/macism")
  end,
})

-- 在进入插入模式时恢复输入法状态
vim.api.nvim_create_autocmd("InsertEnter", {
  group = im_select_group,
  callback = function()
    if last_im_select ~= "" then
      vim.fn.system("/opt/homebrew/bin/macism " .. last_im_select)
    end
  end,
})

-- 移除注释行创建新行的时候自动添加注释前缀
-- 移除自动注释选项
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "o", "r" })
  end,
})

-- ============================================================================
-- Markdown ↔ Tree 转换功能
-- ============================================================================

-- 获取 visual selection 的内容
local function get_visual_selection()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  return vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), start_line, end_line
end

-- 替换 visual selection 的内容
local function replace_visual_selection(lines, start_line, end_line)
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end

-- 解析 markdown 标题
local function parse_markdown_headers(lines)
  local headers = {}
  for _, line in ipairs(lines) do
    -- 清理异常字符
    line = line:gsub("[\128-\255]", ""):gsub("<80>", "")

    local trimmed = line:match("^%s*(.-)%s*$") -- 去除首尾空格
    if trimmed:match("^#+%s") then
      local level = 0
      local content = trimmed

      -- 计算 # 的数量
      while content:sub(1, 1) == "#" do
        level = level + 1
        content = content:sub(2)
      end

      content = content:match("^%s*(.*)") or "" -- 去除开头空格
      if content ~= "" then
        table.insert(headers, { level = level, content = content })
      end
    end
  end
  return headers
end

-- 将标题转换为树形结构
local function headers_to_tree(headers)
  if #headers == 0 then
    return {}
  end

  local result = {}

  -- 添加根目录标识
  table.insert(result, ".")

  for i, header in ipairs(headers) do
    local level = header.level
    local content = header.content

    -- 所有标题都作为子节点处理，在原级别基础上统一缩进
    local prefix = ""

    -- 计算缩进和连接符，从级别1开始都需要前缀
    for depth = 1, level do
      if depth == level then
        -- 当前层级，判断是否是最后一个
        local is_last = true
        for j = i + 1, #headers do
          if headers[j].level == level then
            is_last = false
            break
          elseif headers[j].level < level then
            break
          end
        end
        prefix = prefix .. (is_last and "└── " or "├── ")
      else
        -- 父层级，判断是否还有同级后续节点
        local has_more = false
        for j = i + 1, #headers do
          if headers[j].level == depth then
            has_more = true
            break
          elseif headers[j].level < depth then
            break
          end
        end
        prefix = prefix .. (has_more and "│   " or "    ")
      end
    end

    table.insert(result, prefix .. content)
  end

  return result
end

-- Markdown → Tree 主函数
local function markdown_to_tree()
  local lines, start_line, end_line = get_visual_selection()

  if #lines == 0 then
    print("没有选中任何内容")
    return
  end

  local headers = parse_markdown_headers(lines)
  if #headers == 0 then
    print("没有找到 markdown 标题")
    return
  end

  local tree_lines = headers_to_tree(headers)
  replace_visual_selection(tree_lines, start_line, end_line)
end

-- ============================================================================
-- 用户命令和快捷键
-- ============================================================================

-- 创建用户命令
vim.api.nvim_create_user_command("MarkdownToTree", markdown_to_tree, {
  desc = "Convert markdown headers to directory tree",
})

-- 设置快捷键
vim.keymap.set("v", "<leader>mt", markdown_to_tree, {
  desc = "Convert markdown headers to directory tree",
})
