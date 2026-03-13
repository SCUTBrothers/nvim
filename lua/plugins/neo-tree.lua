return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["F"] = {
          command = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.system({ "open", "-R", path })
          end,
          desc = "Reveal in Finder",
        },
      },
    },
    filesystem = {
      filtered_items = {
        visible = false, -- 默认显示隐藏文件（灰色），按 H 切换
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
