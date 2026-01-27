-- 在 snippet 活跃时禁用 copilot inline suggestion
-- 解决 LuaSnip extmarks 被破坏的问题
-- https://github.com/zbirenbaum/copilot.lua/issues/315

local function is_in_snippet()
  local luasnip_ok, luasnip = pcall(require, "luasnip")
  return luasnip_ok and luasnip.in_snippet()
end

return {
  -- 对于 copilot.lua
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      suggestion = {
        auto_trigger = true,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)

      -- 用 CursorMovedI 检测 snippet 状态并控制 copilot
      local copilot_suggestion = require("copilot.suggestion")
      vim.api.nvim_create_autocmd("CursorMovedI", {
        callback = function()
          if is_in_snippet() then
            copilot_suggestion.dismiss()
          end
        end,
      })
    end,
  },

  -- 对于 copilot-native (github/copilot.vim)
  {
    "github/copilot.vim",
    optional = true,
    init = function()
      local copilot_enabled = true

      vim.api.nvim_create_autocmd("CursorMovedI", {
        callback = function()
          if is_in_snippet() then
            if copilot_enabled then
              vim.cmd("Copilot disable")
              copilot_enabled = false
            end
          else
            if not copilot_enabled then
              vim.cmd("Copilot enable")
              copilot_enabled = true
            end
          end
        end,
      })
    end,
  },
}
