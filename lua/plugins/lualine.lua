return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- 禁用底部状态栏的面包屑导航 (navic)
    opts.sections = opts.sections or {}
    opts.sections.lualine_c = {
      -- 只显示文件路径
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename", path = 1 }, -- path=1 显示相对路径
    }
  end,
}
