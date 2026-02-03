return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- 显示隐藏文件
        hide_dotfiles = false,
        hide_gitignored = false,
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
