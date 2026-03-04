-- leetcode-compat: 兼容 VSCode LeetCode 插件文件格式的 Neovim LeetCode 工具
return {
  dir = "~/Documents/leetcode-nvim",
  dependencies = { "ibhagwan/fzf-lua" },
  cmd = { "LCList", "LCOpen", "LCRun", "LCSubmit", "LCDesc", "LCAuth", "LCInfo", "LCPractice" },
  keys = {
    { "<leader>kl", "<cmd>LCList<cr>", desc = "LeetCode: Browse problems" },
    { "<leader>ko", ":LCOpen ", desc = "LeetCode: Open by ID" },
    { "<leader>kr", "<cmd>LCRun<cr>", desc = "LeetCode: Run test cases" },
    { "<leader>ks", "<cmd>LCSubmit<cr>", desc = "LeetCode: Submit solution" },
    { "<leader>kd", "<cmd>LCDesc<cr>", desc = "LeetCode: Problem description" },
    { "<leader>ki", "<cmd>LCInfo<cr>", desc = "LeetCode: Problem info" },
    { "<leader>ka", "<cmd>LCAuth<cr>", desc = "LeetCode: Set cookie" },
    { "<leader>kp", ":LCPractice ", desc = "LeetCode: Practice by ID (reset)" },
  },
  opts = {
    workspace = vim.fn.expand("~/Documents/obsidian-workspace/programming/leetcode/workspace"),
    lang = "javascript",
    cn = true,
    picker = "fzf",
  },
}
