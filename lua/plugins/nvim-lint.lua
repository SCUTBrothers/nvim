return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = {
        cmd = "markdownlint-cli2",
        stdin = false,
        args = {
          "--config",
          function()
            -- 查找配置文件
            local configs = {
              ".markdownlint-cli2.yaml",
              ".markdownlint.json",
              vim.fn.expand("~/.markdownlint.json"),
            }

            for _, config in ipairs(configs) do
              if vim.fn.filereadable(config) == 1 then
                return config
              end
            end

            -- 如果没找到，返回默认值
            return vim.fn.expand("~/.markdownlint.json")
          end,
          "--",
        },
      },
    },
  },
}
