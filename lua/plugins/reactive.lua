return {
  "rasulomaroff/reactive.nvim",
  config = function()
    -- 根据背景色选择对应的主题预设
    local flavor = vim.o.background == "dark" and "mocha" or "latte"

    require("reactive").setup({
      load = {
        "catppuccin-" .. flavor .. "-cursor",
        "catppuccin-" .. flavor .. "-cursorline",
      },
    })
  end,
}
