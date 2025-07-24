return {
  "echasnovski/mini.ai",
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
