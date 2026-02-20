return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  keys = {
    {
      "<leader>mp",
      function()
        -- 将图片保存到当前文件所在目录的 _images 下
        local buf_dir = vim.fn.expand("%:p:h")
        local img_dir = buf_dir .. "/_images"
        vim.fn.mkdir(img_dir, "p")
        local timestamp = os.date("%Y%m%d%H%M%S")
        local fname = "image-" .. timestamp .. ".png"
        local filepath = img_dir .. "/" .. fname
        -- 使用 pngpaste 保存剪贴板图片
        local result = vim.fn.system({ "pngpaste", filepath })
        if vim.v.shell_error ~= 0 then
          vim.notify("粘贴图片失败: " .. result, vim.log.levels.ERROR)
          return
        end
        -- 插入相对路径的 markdown 图片链接
        local link = string.format("![%s](%s)", fname, "_images/" .. fname)
        vim.api.nvim_put({ link }, "c", true, true)
        vim.notify("已粘贴图片: " .. fname, vim.log.levels.INFO)
      end,
      desc = "Paste image",
      ft = "markdown",
    },
  },
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/obsidian-workspace",
      },
      {
        name = "work",
        path = "~/Documents/xp",
      },
    },

    -- gf 映射：图片文件在 buffer 中打开（snacks image 渲染），其他走 obsidian 默认逻辑
    mappings = {
      ["gf"] = {
        action = function()
          local util = require("obsidian.util")
          if util.cursor_on_markdown_link() then
            local line = vim.api.nvim_get_current_line()
            local path = line:match("%[.-%]%((.-)%)")
            if path and (path:match("%.png$") or path:match("%.jpe?g$") or path:match("%.gif$") or path:match("%.webp$") or path:match("%.svg$")) then
              local buf_dir = vim.fn.expand("%:p:h")
              local abs_path = buf_dir .. "/" .. path
              if vim.fn.filereadable(abs_path) == 1 then
                vim.cmd("edit " .. vim.fn.fnameescape(abs_path))
              else
                vim.notify("图片文件不存在: " .. abs_path, vim.log.levels.ERROR)
              end
              return
            end
          end
          return vim.cmd("ObsidianFollowLink")
        end,
        opts = { noremap = false, expr = false, buffer = true, desc = "Go to file" },
      },
    },

    -- 禁用 Obsidian 的 UI，使用 render-markdown.nvim 代替
    ui = {
      enable = false,
    },

    -- 不自动插入 yaml  frontmatter
    disable_frontmatter = true,

    -- 图片粘贴配置
    attachments = {
      -- 图片保存到当前文件同级的 _images 目录
      img_folder = "_images",
      ---@param client obsidian.Client
      ---@param path obsidian.Path
      ---@return string
      img_text_func = function(client, path)
        -- 生成相对路径的 markdown 图片链接
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
    -- see below for full list of options 👇
  },
}
