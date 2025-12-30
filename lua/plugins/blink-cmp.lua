return {
  "saghen/blink.cmp",
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
  },
  opts = {
    sources = {
      default = { "lsp", "path", "snippets" }, -- 移除 buffer 禁用单词补全
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
