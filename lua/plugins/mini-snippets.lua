return {
  "echasnovski/mini.snippets",
  event = "InsertEnter", -- don't depend on other plugins to load...
  dependencies = "rafamadriz/friendly-snippets",
  opts = {
    mappings = {
      -- 默认使用 <c-c> 来退出snippet session并清除range extmarks
      -- 改为使用 <esc> 来退出, 当进入到normal模式的时候, 自动退出snippet
      stop = "<esc>",
    },
  },
}
