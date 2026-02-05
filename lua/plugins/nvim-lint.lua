return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    },
    linters = {
      ["markdownlint-cli2"] = {
        prepend_args = { "--config", vim.fn.expand("~/.markdownlint-cli2.jsonc") },
      },
    },
  },
}
