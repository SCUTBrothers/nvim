return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      -- 使用 enter 预设，但禁用 Tab 选择补全项
      preset = "enter",
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        -- 仅保留 snippet 跳转和 copilot 接受，移除补全选择
        LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
      ["<S-Tab>"] = {
        LazyVim.cmp.map({ "snippet_backward" }),
        "fallback",
      },
    },
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
          -- 禁用 treesitter 高亮（空表表示不对任何来源使用 treesitter）
          treesitter = {},
        },
      },
    },
    -- 函数参数提示
    signature = { enabled = false },
  },
}
