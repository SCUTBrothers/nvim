return {
  "L3MON4D3/LuaSnip",
  opts = function(_, opts)
    local types = require("luasnip.util.types")

    -- 更精确的 snippet 退出检测
    opts.delete_check_events = "TextChanged,InsertLeave"

    -- snippet stop 视觉增强（仅虚拟文本，无背景色）
    opts.ext_opts = {
      [types.insertNode] = {
        active = {
          virt_text = { { "|", "CursorLineNr" } },
        },
      },
      [types.choiceNode] = {
        active = {
          virt_text = { { " <- Choice", "Comment" } },
        },
      },
    }

    return opts
  end,
}
