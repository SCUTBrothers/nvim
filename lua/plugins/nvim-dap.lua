return {
  "mfussenegger/nvim-dap",
  opts = function()
    local dap = require("dap")

    -- 使用 mason 安装的 js-debug-adapter
    if not dap.adapters["pwa-chrome"] then
      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
    end

    -- JavaScript/TypeScript 配置
    local js_config = {
      -- Launch Chrome
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch Chrome",
        url = function()
          local co = coroutine.running()
          return coroutine.create(function()
            vim.ui.input({ prompt = "URL: ", default = "http://localhost:3000" }, function(url)
              if url == nil or url == "" then
                return
              else
                coroutine.resume(co, url)
              end
            end)
          end)
        end,
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
      },
      -- Attach to Chrome (需要 Chrome 以 --remote-debugging-port=9222 启动)
      {
        type = "pwa-chrome",
        request = "attach",
        name = "Attach Chrome",
        port = 9222,
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        sourceMapPathOverrides = {
          ["webpack:///./src/*"] = "${workspaceFolder}/src/*",
          ["webpack://./src/*"] = "${workspaceFolder}/src/*",
          ["webpack:///../../packages/*"] = "${workspaceFolder}/../../packages/*",
          ["webpack://../../packages/*"] = "${workspaceFolder}/../../packages/*",
          ["webpack://?:*/*"] = "${workspaceFolder}/*",
          ["webpack:///./*"] = "${workspaceFolder}/*",
        },
        skipFiles = { "**/node_modules/**/*.js" },
      },
      -- Attach Chrome (选择子目录作为 webRoot)
      {
        type = "pwa-chrome",
        request = "attach",
        name = "Attach Chrome (select webRoot)",
        port = 9222,
        webRoot = function()
          return vim.fn.input("webRoot: ", vim.fn.getcwd() .. "/", "dir")
        end,
        sourceMaps = true,
        sourceMapPathOverrides = {
          ["webpack:///./src/*"] = "${webRoot}/src/*",
          ["webpack://./src/*"] = "${webRoot}/src/*",
          ["webpack:///../../packages/*"] = "${webRoot}/../../packages/*",
          ["webpack://?:*/*"] = "${webRoot}/*",
          ["webpack:///./*"] = "${webRoot}/*",
        },
        skipFiles = { "**/node_modules/**/*.js" },
      },
      -- Attach to Chrome (自定义端口)
      {
        type = "pwa-chrome",
        request = "attach",
        name = "Attach Chrome (custom port)",
        port = function()
          return tonumber(vim.fn.input("Port: ", "9222"))
        end,
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
      },
    }

    -- 应用到所有前端文件类型
    for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
      dap.configurations[lang] = js_config
    end
  end,
}
