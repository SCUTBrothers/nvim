return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      -- 使用 enter 预设，但禁用 Tab 选择补全项
      preset = "enter",
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        "accept",
        LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
      ["<S-Tab>"] = {
        LazyVim.cmp.map({ "snippet_backward" }),
        "fallback",
      },
    },
    sources = {
      default = { "lsp", "path" },
      -- 过滤掉 Text 和 LSP 返回的 Snippet 类型补全项（保留 snippets 源自身的）
      transform_items = function(_, items)
        local kind = require("blink.cmp.types").CompletionItemKind
        return vim.tbl_filter(function(item)
          if item.kind == kind.Text then return false end
          if item.kind == kind.Snippet and item.source_id ~= "snippets" then return false end
          return true
        end, items)
      end,
    },
    completion = {
      list = { max_items = 15 },
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
