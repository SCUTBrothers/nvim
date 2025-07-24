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

vim.api.nvim_create_user_command("CopyRelPath", function()
  vim.api.nvim_call_function("setreg", { "+", vim.fn.fnamemodify(vim.fn.expand("%"), ":.") })
end, {})

vim.api.nvim_create_user_command("CopyAbsPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied absolute path: " .. path)
end, {})

-- 创建自动命令组
local im_select_group = vim.api.nvim_create_augroup("im_select", { clear = true })

-- 在退出插入模式时切换到英文输入法
vim.api.nvim_create_autocmd("InsertLeave", {
  group = im_select_group,
  callback = function()
    -- 设置按键序列的超时时间（毫秒）: 当你输入一个可能是映射开头的按键时，Vim 会等待 timeoutlen 毫秒来判断你是否要输入一个完整的按键映射
    -- 这个可能会导致其他的remap映射失效
    vim.opt.timeoutlen = 0
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

-- Markdown标题转目录树结构
local function markdown_to_tree()
  -- 获取visual模式下选中的文本
  local start_line = vim.fn.line("'<") - 1 -- 转换为0-based索引
  local end_line = vim.fn.line("'>") -- 包含结束行
  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

  if #lines == 0 then
    print("没有选中任何内容")
    return
  end

  -- 解析markdown标题
  local items = {}
  for _, line in ipairs(lines) do
    local level = 0
    local text = line

    -- 计算标题级别
    while text:sub(1, 1) == "#" do
      level = level + 1
      text = text:sub(2)
    end

    if level > 0 then
      text = text:gsub("^%s+", ""):gsub("%s+$", "") -- 去除首尾空格
      table.insert(items, { level = level, text = text })
    end
  end

  if #items == 0 then
    print("没有找到markdown标题")
    return
  end

  -- 生成目录树
  local result = {}

  for i, item in ipairs(items) do
    local level = item.level
    local text = item.text

    -- 检查是否是同级别的最后一个
    local is_last = true
    for j = i + 1, #items do
      if items[j].level <= level then
        if items[j].level == level then
          is_last = false
        end
        break
      end
    end

    -- 生成前缀和连接符
    local line = ""
    if level == 1 then
      line = text
    else
      -- 计算前缀
      local prefix = ""
      for depth = 2, level do
        -- 检查这个深度是否还有后续项目
        local has_more_at_depth = false
        for k = i + 1, #items do
          if items[k].level < depth then
            break
          elseif items[k].level == depth then
            has_more_at_depth = true
            break
          end
        end

        if depth == level then
          -- 当前级别
          local connector = is_last and "└── " or "├── "
          prefix = prefix .. connector
        else
          -- 父级别
          if has_more_at_depth then
            prefix = prefix .. "│   "
          else
            prefix = prefix .. "    "
          end
        end
      end
      line = prefix .. text
    end

    table.insert(result, line)
  end

  -- 替换选中的内容
  vim.api.nvim_buf_set_lines(0, start_line, end_line, false, result)
end

-- 创建用户命令
vim.api.nvim_create_user_command("MarkdownToTree", markdown_to_tree, { range = true })

-- 设置visual模式快捷键
vim.keymap.set("v", "<leader>mt", markdown_to_tree, { desc = "Convert markdown headers to directory tree" })
