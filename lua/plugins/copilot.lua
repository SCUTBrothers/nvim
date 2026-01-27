-- copilot-native snippet 冲突处理
-- 在 snippet 活跃时禁用 inline completion，防止 extmarks 被破坏
-- https://github.com/zbirenbaum/copilot.lua/issues/315

local function is_in_snippet()
  local ok, luasnip = pcall(require, "luasnip")
  return ok and luasnip.in_snippet()
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local inline_disabled = false
      local group = vim.api.nvim_create_augroup("copilot_snippet_guard", { clear = true })

      vim.api.nvim_create_autocmd("CursorMovedI", {
        group = group,
        callback = function()
          if is_in_snippet() then
            if not inline_disabled then
              pcall(vim.lsp.inline_completion.disable)
              inline_disabled = true
            end
          else
            if inline_disabled then
              pcall(vim.lsp.inline_completion.enable)
              inline_disabled = false
            end
          end
        end,
      })
    end,
  },
}
