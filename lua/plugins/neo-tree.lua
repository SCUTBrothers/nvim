return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- 默认显示隐藏文件（灰色），按 H 切换
        hide_dotfiles = true,
        hide_gitignored = true,
        -- 始终隐藏这些文件
        always_show = {},
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
  },
}
