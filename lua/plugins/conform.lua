return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      -- prettier 禁用 trailing comma
      prettier = {
        prepend_args = { "--trailing-comma", "none" },
      },
    },
  },
}
