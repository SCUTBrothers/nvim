if true then
  return {}
else
end

return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      layout_config = {
        prompt_position = "top", -- 关键设置
      },
      sorting_strategy = "ascending",
    },
  },
}
