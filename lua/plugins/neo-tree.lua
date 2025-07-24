return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false, -- 不隐藏点文件
      },
    },
    window = {
      mappings = {
        ["E"] = "expand_all_subnodes", -- 展开当前节点的所有子节点
      },
    },
  },
}
