-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set


if vim.g.vscode then
  -- VSCode 专用键位映射
  local vscode = require("vscode")
  local action = vscode.action

  -- 基础移动与命令映射
  map("n", "H", "^", { desc = "移动到行首" })
  map("n", "L", "$", { desc = "移动到行尾" })
  map("n", ";", ":", { desc = "进入命令模式" })
  map("n", ":", function() action("workbench.action.showCommands") end, { desc = "显示命令面板" })
  map("n", ",", "%", { desc = "匹配括号跳转" })
  map("o", "H", "^", { desc = "移动到行首" })
  map("o", "L", "$", { desc = "移动到行尾" })
  map("v", "H", "0", { desc = "移动到行首" })
  map("v", "L", "g_", { desc = "移动到行尾非空白字符" })
  map("v", ":", ";", { desc = "进入命令模式" })
  map("v", ":", function() action("workbench.action.showCommands") end, { desc = "显示命令面板" })
  map("v", "-", "%", { desc = "匹配括号跳转" })

  -- 标签和编辑器切换
  map("n", "J", function() action("workbench.action.previousEditorInGroup") end, { desc = "上一个标签" })
  map("n", "K", function() action("workbench.action.nextEditorInGroup") end, { desc = "下一个标签" })
  map("n", "<leader>1", function() action("workbench.action.focusFirstEditorGroup") end, { desc = "聚焦第一编辑器组" })
  map("n", "<leader>2", function() action("workbench.action.focusRightGroup") end, { desc = "聚焦第二编辑器组" })
  map("n", "<leader>i", function() action("workbench.action.switchWindow") end, { desc = "切换窗口" })

  -- 编辑器管理
  map("n", "<leader>be", function() action("workbench.action.closeEditorsInOtherGroups") end, { desc = "关闭其他组编辑器" })
  map("n", "<leader>bl", function() action("workbench.action.toggleEditorGroupLock") end, { desc = "切换编辑器组锁定" })
  map("n", "<leader>bo", function()
    action("workbench.action.closeEditorsToTheLeft")
    action("workbench.action.closeEditorsToTheRight")
  end, { desc = "关闭左侧和右侧的编辑器" })
  map("n", "<leader>bp", function() action("workbench.action.pinEditor") end, { desc = "固定编辑器" })
  map("n", "<leader>bP", function() action("workbench.action.unpinEditor") end, { desc = "取消固定编辑器" })
  map("n", "q", function()
      action("workbench.action.files.saveFiles")
      action("workbench.action.closeActiveEditor")
  end, { desc = "保存并关闭" })
  map("n", "<leader>mh", function() action("workbench.action.moveEditorToLeftGroup") end, { desc = "移动编辑器到左组" })
  map("n", "<leader>ml", function() action("workbench.action.moveEditorToRightGroup") end, { desc = "移动编辑器到右组" })

  -- 文件与搜索操作
  map("n", "-", function() action("extension.showDirectoryFiles") end, { desc = "显示目录文件" })
  map("n", "<leader>e", function() action("workbench.view.explorer") end, { desc = "显示资源管理器" })
  map("n", "<leader>ff", function() action("workbench.action.quickOpen") end, { desc = "快速打开" })
  map("n", "<leader>sg", function() action("workbench.action.quickOpen", { args = { "%" } }) end, { desc = "全局搜索" })
  map("n", "<leader>ss", function() action("workbench.action.gotoSymbol") end, { desc = "转到符号" })
  map("n", "<leader>sS", function() action("workbench.action.showAllSymbols") end, { desc = "显示所有符号" })
  map("v", "s", "<leader><leader>s", { desc = "快速查找" })

  -- Git 相关操作
  map("n", "<leader>gg", function() action("git.checkout") end, { desc = "Git检出" })
  map("n", "<leader>gb", function() action("git.branch") end, { desc = "Git 分支" })
  map("n", "<leader>gc", function() action("git.openChange") end, { desc = "打开 Git 变更" })
  map("n", "<leader>gd", function()
    action("git.refresh")
    action("git.cleanAll")
  end, { desc = "刷新 Git 并清理" })
  map("n", "<leader>gm", function() action("git.merge") end, { desc = "Git 合并" })
  map("n", "<leader>gs", function() action("git.stash") end, { desc = "Git 储藏" })
  map("n", "<leader>gu", function() action("git.stashPop") end, { desc = "Git 弹出储藏" })

  -- 导航与跳转
  map("n", "<leader>j", function() action("bookmarks.jumpToNext") end, { desc = "下一个书签" })
  map("n", "<leader>k", function() action("bookmarks.jumpToPrevious") end, { desc = "上一个书签" })
  map("n", "_", function()
    action("editor.action.marker.prev")
    action("extension.vim_left")
    action("extension.vim_escape")
    action("extension.vim_right")
  end, { desc = "上一个标记" })
  map("n", "[d", function() action("editor.action.marker.prev") end, { desc = "下一个标记" })
  map("n", "]d", function() action("editor.action.marker.next") end, { desc = "下一个标记" })
  map("n", "[c", function() action("workbench.action.editor.previousChange") end, { desc = "上一个变更" })
  map("n", "]c", function() action("workbench.action.editor.nextChange") end, { desc = "下一个变更" })
  map("n", "[h", function() action("editor.action.dirtydiff.previous") end, { desc = "上一个差异" })
  map("n", "]h", function() action("editor.action.dirtydiff.next") end, { desc = "下一个差异" })
  map("n", "[t", function() action("todo-tree.goToPrevious") end, { desc = "上一个TODO" })
  map("n", "]t", function() action("todo-tree.goToNext") end, { desc = "下一个TODO" })

  -- 代码导航与查询
  map("n", "gh", function() action("editor.action.showDefinitionPreviewHover") end, { desc = "显示定义预览" })
  map("n", "gl", function() action("editor.action.openLink") end, { desc = "打开链接" })
  map("n", "gr", function() action("editor.action.referenceSearch.trigger") end, { desc = "查找引用" })
  map("n", "gt", function() action("editor.action.goToTypeDefinition") end, { desc = "转到类型定义" })
  map("n", "cd", function() action("editor.action.rename") end, { desc = "重命名" })

  -- 文本格式化与转换
  map("n", "\\c", function() action("editor.action.transformToCamelcase") end, { desc = "转换为驼峰命名" })
  map("n", "\\p", function() action("extension.changeCase.pascal") end, { desc = "转换为帕斯卡命名" })
  map("n", "\\s", function() action("editor.action.transformToSnakecase") end, { desc = "转换为蛇形命名" })
  map("n", "\\t", function() action("editor.action.transformToTitlecase") end, { desc = "转换为标题命名" })
  map("n", "\\u", function() action("editor.action.transformToUppercase") end, { desc = "转换为大写" })
  map("v", "\\c", function() action("editor.action.transformToCamelcase") end, { desc = "转换为驼峰命名" })
  map("v", "\\d", function() action("editor.action.transformToLowercase") end, { desc = "转换为小写" })
  map("v", "\\p", function() action("extension.changeCase.pascal") end, { desc = "转换为帕斯卡命名" })
  map("v", "\\s", function() action("editor.action.transformToSnakecase") end, { desc = "转换为蛇形命名" })
  map("v", "\\t", function() action("editor.action.transformToTitlecase") end, { desc = "转换为标题命名" })

  -- 缩进操作
  map("n", "<", function() action("editor.action.outdentLines") end, { desc = "减少缩进" })
  map("n", ">", function() action("editor.action.indentLines") end, { desc = "增加缩进" })

  -- 文件操作
  map("n", "<leader>nf", function() action("fileutils.newFolder") end, { desc = "新建文件夹" })
  map("n", "<leader>nd", function() action("fileutils.removeFile") end, { desc = "删除文件" })
  map("n", "<leader>na", function() action("fileutils.newFile") end, { desc = "新建文件" })
  map("n", "<leader>nn", function() action("fileutils.renameFile") end, { desc = "重命名文件" })
  map("n", "<leader>nt", function() action("workbench.action.populateFileFromSnippet") end, { desc = "从代码片段生成文件" })
  map("n", "<leader>yy", function() action("copyRelativeFilePath") end, { desc = "复制相对文件路径" })

  -- 反引号块操作
  map("n", "cag", "ca`", { desc = "修改一个反引号块" })
  map("n", "cig", "ci`", { desc = "修改反引号块内容" })
  map("n", "dag", "da`", { desc = "删除一个反引号块" })
  map("n", "dig", "di`", { desc = "删除反引号块内容" })
  map("n", "vag", "va`", { desc = "选择一个反引号块" })
  map("n", "vig", "vi`", { desc = "选择反引号块内容" })
  map("n", "yag", "ya`", { desc = "复制一个反引号块" })
  map("n", "yig", "yi`", { desc = "复制反引号块内容" })

  -- UI 控制与视图
  map("n", "<leader>ud", function() action("workbench.debug.action.toggleRepl") end, { desc = "切换调试REPL" })
  map("n", "<leader>ue", function() action("workbench.action.toggleSidebarVisibility") end, { desc = "切换侧边栏可见性" })
  map("n", "<leader>ug", function() action("workbench.view.scm") end, { desc = "显示源代码管理" })
  map("n", "<leader>um", function() action("markdown-preview-enhanced.openPreviewToTheSide") end, { desc = "打开Markdown预览" })
  map("n", "<leader>uo", function() action("outline.focus") end, { desc = "聚焦大纲" })
  map("n", "<leader>up", function() action("workbench.view.extensions") end, { desc = "查看扩展" })
  map("n", "<leader>us", function() action("workbench.action.closeAuxiliaryBar") end, { desc = "关闭辅助栏" })
  map("n", "<leader>ut", function() action("workbench.view.testing.focus") end, { desc = "聚焦测试视图" })
  map("n", "<leader>v", function() action("editor.toggleFold") end, { desc = "切换折叠" })

  -- 智能编辑与修复
  map("n", "m", function() action("editor.action.quickFix") end, { desc = "快速修复" })
  map("v", "m", function() action("editor.action.quickFix") end, { desc = "快速修复" })
  map("n", "<leader>t", function() action("editor.emmet.action.matchTag") end, { desc = "匹配标签" })
  map("v", "[[", function() action("editor.action.smartSelect.shrink") end, { desc = "智能选择收缩" })
  map("v", "]]", function() action("editor.action.smartSelect.expand") end, { desc = "智能选择扩展" })

  -- 聊天与内联工具
  map("n", "gc", function() action("inlineChat.start") end, { desc = "启动内联聊天" })
  map("v", "gc", function() action("inlineChat.start") end, { desc = "启动内联聊天" })

  -- 包围与Emmet
  map("v", "o", function()
    action("surround.with.templateLiteral")
    action("extension.vim_escape")
  end, { desc = "用模板字面量包围" })
  map("v", "S", function() action("surround.with") end, { desc = "包围" })
  map("v", "W", function() action("editor.emmet.action.wrapWithAbbreviation") end, { desc = "Emmet包裹" })

  -- ASCII树生成
  map("v", "t", function() action("extension.asciiTreeGeneratorFromText") end, { desc = "文本生成ASCII树" })
  map("v", "T", function() action("extension.asciiTreeGeneratorRevertToText") end, { desc = "ASCII树恢复为文本" })

  -- 终端与任务
  map("n", "<leader>w", function() action("workbench.action.terminal.newInActiveWorkspace") end, { desc = "新建终端" })
  map("n", "<leader>0", function() action("workbench.action.tasks.runTask") end, { desc = "运行任务" })
  map("n", "<leader>r", function() action("workbench.action.tasks.reRunTask") end, { desc = "重新运行任务" })

  -- REPL与特殊功能
  map("n", "Q", "q", { desc = "录制宏" })
  map("v", "Q", "q", { desc = "退出visual模式" })
  map("v", "p", "pgvy", { desc = "粘贴并保持选择" })

  -- 其他功能
  map("n", "<leader>ls", function() action("leetcode.searchProblem") end, { desc = "LeetCode 搜索题目" })

else
  -- 基础移动映射
  map("n", "H", "^", { desc = "move to line start" })
  map("n", "L", "$", { desc = "move to line start" })

  -- buffer操作
  map("n", "<S-j>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<S-k>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

  -- 文件浏览
  map("n", "-", "<cmd>Oil --float<cr>", { desc = "Open Parent Directory in Oil" })
end
