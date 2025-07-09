return {
  "echasnovski/mini.ai",
  opts = function(_, opts)
    local ai = require("mini.ai")
    opts.custom_textobjects.x = ai.gen_spec.treesitter({
      a = "@attribute.outer",
      i = "@attribute.inner",
    })

    -- 添加 e 作为整个 buffer 的 textobject
    opts.custom_textobjects.e = function()
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line("$"),
        col = math.max(vim.fn.getline("$"):len(), 1),
      }
      return { from = from, to = to }
    end

    return opts
  end,
}
