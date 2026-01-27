return {
  "saghen/blink.cmp",
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
  },
  opts = {
    sources = {
      default = { "snippets", "lsp", "path" }, -- snippets 优先，移除 buffer
      providers = {
        snippets = {
          score_offset = 100, -- 提高 snippets 优先级
        },
      },
    },
    completion = {
      accept = {
        -- 禁用自动插入函数参数
        auto_brackets = {
          enabled = false,
        },
      },
    },
  },
}
