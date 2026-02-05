return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    -- 默认禁用，需要时用 :RenderMarkdown toggle 开启
    enabled = false,
    -- 使用 obsidian 预设，模拟 Obsidian 编辑器的 UI 风格
    preset = "obsidian",
    -- WikiLink 渲染配置
    link = {
      wiki = {
        icon = "󰌹 ",
      },
    },
    -- checkbox 配置，支持 Obsidian 风格
    checkbox = {
      custom = {
        -- 支持 [>] 表示转发/推迟
        forward = { raw = "[>]", rendered = "󰒊 ", highlight = "RenderMarkdownTodo" },
        -- 支持 [<] 表示计划安排
        schedule = { raw = "[<]", rendered = "󰃰 ", highlight = "RenderMarkdownTodo" },
        -- 支持 [-] 表示取消
        cancelled = { raw = "[-]", rendered = "󰜺 ", highlight = "RenderMarkdownError" },
        -- 支持 [/] 表示进行中
        in_progress = { raw = "[/]", rendered = "󰔟 ", highlight = "RenderMarkdownWarn" },
        -- 支持 [?] 表示疑问
        question = { raw = "[?]", rendered = "󰋗 ", highlight = "RenderMarkdownWarn" },
        -- 支持 [!] 表示重要
        important = { raw = "[!]", rendered = "󰀨 ", highlight = "RenderMarkdownError" },
      },
    },
  },
}
