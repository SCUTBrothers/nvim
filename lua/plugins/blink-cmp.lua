return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      default = { "lsp", "snippets", "path" },
      providers = {
        snippets = {
          score_offset = 80,
        },
      },
    },
    completion = {
      accept = {
        auto_brackets = { enabled = false },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
      },
      -- 避免与 copilot-native inline suggestion 冲突
      ghost_text = { enabled = false },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
    },
    -- 函数参数提示
    signature = { enabled = true },
  },
}
