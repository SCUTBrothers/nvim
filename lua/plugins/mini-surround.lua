return {
  "nvim-mini/mini.surround",
  opts = {
    custom_surroundings = {
      -- B = markdown 加粗 **text**
      B = { output = { left = "**", right = "**" } },
      -- I = markdown 斜体 *text*
      I = { output = { left = "*", right = "*" } },
      -- C = markdown 行内代码 `text`
      C = { output = { left = "`", right = "`" } },
      -- K = markdown 代码块
      K = { output = { left = "```\n", right = "\n```" } },
      -- S = markdown 删除线 ~~text~~
      S = { output = { left = "~~", right = "~~" } },
      -- H = markdown 高亮 ==text==
      H = { output = { left = "==", right = "==" } },
    },
  },
}
