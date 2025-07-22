return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = false, -- 手动触发
      keymap = {
        accept = "<C-l>", -- Ctrl+l 接受建议
        next = "<C-j>", -- Ctrl+j 下一个建议
        prev = "<C-k>", -- Ctrl+k 上一个建议
        dismiss = "<C-h>", -- Ctrl+h 忽略建议
      },
    },
    panel = {
      enabled = true,
    },
  },
}