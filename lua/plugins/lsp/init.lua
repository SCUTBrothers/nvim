return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
			},

			diagnostic = {
				virtual_text = true,
				signs = true,
				update_in_insert = false,
			},
		},
		config = function(_, opts)
			local utils = require("utils")

			utils.on_attach(function(client, buf)
				require("plugins.lsp.keymaps").on_attach(client, buf)
			end)

			-- get all the servers that are available thourgh mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			local lspconfig = require("lspconfig")
			local servers = opts.servers
			local ensure_installed = {}
			for server, server_opts in pairs(servers) do
				ensure_installed[#ensure_installed + 1] = server
				lspconfig[server].setup(server_opts)
			end

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed })
			end

			-- diagnostic
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
			vim.diagnostic.config(vim.deepcopy(opts.diagnostic))
		end,
	},
	-- formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		opts = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.prettier.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"css",
							"less",
							"html",
							"json",
						},
						prefer_local = "node_modules/.bin",
					}),
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
								-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
								vim.lsp.buf.format()
							end,
						})
					end
				end,
			}
		end,
	},

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		opts = { ensure_installed = { "stylua" } },
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}
