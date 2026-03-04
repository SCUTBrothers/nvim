return {
  "nvim-mini/mini.ai",
  opts = function(_, opts)
    local ai = require("mini.ai")
    opts.custom_textobjects.x = ai.gen_spec.treesitter({
      a = "@attribute.outer",
      i = "@attribute.inner",
    })

    -- 添加 e 作为整个 buffer 的 textobject
    opts.custom_textobjects.e = function()
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line("$"),
        col = math.max(vim.fn.getline("$"):len(), 1),
      }
      return { from = from, to = to }
    end

    -- 添加 | 作为 markdown table cell 的 textobject
    -- di| 删除单元格内容, ci| 修改单元格内容
    opts.custom_textobjects["|"] = { "%|().-()%|" }

    -- 添加 L 作为 URL/Link 的 textobject
    -- diL 删除 URL, ciL 修改 URL, yiL 复制 URL
    opts.custom_textobjects["L"] = { "https?://[^%s<>\"'`%)%]]*" }

    -- 添加 h 作为 markdown section (heading + content) 的 textobject
    -- vah/dah 选择当前 section（标题 + 内容直到下一个同级或更高级标题）
    -- vih/dih 只选择内容（不含标题行）
    opts.custom_textobjects.h = function(ai_type)
      local total_lines = vim.fn.line("$")

      -- 收集所有 heading 的位置和级别
      local headings = {}
      for i = 1, total_lines do
        local line = vim.fn.getline(i)
        local level = line:match("^(#+)%s")
        if level then
          table.insert(headings, { line = i, level = #level })
        end
      end

      if #headings == 0 then
        return nil
      end

      -- 为每个 heading 构建 section region
      local regions = {}
      for idx, h in ipairs(headings) do
        -- section 结束位置：下一个同级或更高级标题之前，或文件末尾
        local end_line = total_lines
        for j = idx + 1, #headings do
          if headings[j].level <= h.level then
            end_line = headings[j].line - 1
            break
          end
        end

        -- 去除尾部空行
        while end_line > h.line and vim.fn.getline(end_line):match("^%s*$") do
          end_line = end_line - 1
        end

        if ai_type == "i" then
          local content_start = h.line + 1
          while content_start <= end_line and vim.fn.getline(content_start):match("^%s*$") do
            content_start = content_start + 1
          end
          if content_start <= end_line then
            table.insert(regions, {
              from = { line = content_start, col = 1 },
              to = { line = end_line, col = math.max(vim.fn.getline(end_line):len(), 1) },
              vis_mode = "V",
            })
          end
        else
          table.insert(regions, {
            from = { line = h.line, col = 1 },
            to = { line = end_line, col = math.max(vim.fn.getline(end_line):len(), 1) },
            vis_mode = "V",
          })
        end
      end

      if #regions == 0 then
        return nil
      end

      return regions
    end

    -- 添加 c 作为 markdown code block 的 textobject
    opts.custom_textobjects.c = function(ai_type)
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")

      -- 查找当前位置上方最近的 ```
      local start_line = nil
      local start_lang = ""
      for i = current_line, 1, -1 do
        local line = vim.fn.getline(i)
        if line:match("^```") then
          start_line = i
          start_lang = line:match("^```(.*)") or ""
          break
        end
      end

      if not start_line then
        return nil -- 没有找到开始标记
      end

      -- 查找对应的结束 ```
      local end_line = nil
      for i = start_line + 1, total_lines do
        local line = vim.fn.getline(i)
        if line:match("^```%s*$") then
          end_line = i
          break
        end
      end

      if not end_line then
        return nil -- 没有找到结束标记
      end

      -- 检查光标是否在 code block 内部
      if current_line < start_line or current_line > end_line then
        return nil
      end

      -- 根据 ai_type 返回不同的范围
      if ai_type == "i" then
        -- inner: 只包含代码内容
        return {
          from = { line = start_line + 1, col = 1 },
          to = {
            line = end_line - 1,
            col = math.max(vim.fn.getline(end_line - 1):len(), 1),
          },
          vis_mode = "V",
        }
      else
        -- around: 包含 ``` 标记
        return {
          from = { line = start_line, col = 1 },
          to = {
            line = end_line,
            col = math.max(vim.fn.getline(end_line):len(), 1),
          },
          vis_mode = "V",
        }
      end
    end

    return opts
  end,
}
