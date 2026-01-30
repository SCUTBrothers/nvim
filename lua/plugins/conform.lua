return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- markdown 使用 autocorrect（中英文空格）+ prettier
      markdown = { "autocorrect", "prettier" },
    },
    formatters = {
      -- prettier 禁用 trailing comma
      prettier = {
        prepend_args = { "--trailing-comma", "none" },
      },
      -- autocorrect 用于中英文空格自动纠正
      autocorrect = {
        command = "autocorrect",
        args = { "--fix", "$FILENAME" },
        stdin = false,
      },
    },
  },
}
