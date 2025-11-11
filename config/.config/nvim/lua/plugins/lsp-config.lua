return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "ts_ls", "gopls", "pyright", "ruff" }, -- "mypy", "debugpy", "black", -- could these be missing for python debugging?
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				eslint = false,
			},
		},

		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- local lspconfig = require("lspconfig")
			vim.lsp.config("gopls", {
				capabilities = capabilities,
			})
			vim.lsp.enable("gopls")
			-- vim.lsp.gopls()
			-- lspconfig.gopls.setup({
			-- 	capabilities = capabilities,
			-- })

			vim.lsp.config("pyright", {
				capabilities = capabilities,
				settings = {
					pyright = {
						-- Using Ruff's import organizer
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							-- Ignore all files for analysis to exclusively use Ruff for linting
							ignore = { "*" },
						},
					},
				},
			})
			vim.lsp.enable("pyright")
			-- lspconfig.pyright.setup({
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		pyright = {
			-- 			-- Using Ruff's import organizer
			-- 			disableOrganizeImports = true,
			-- 		},
			-- 		python = {
			-- 			analysis = {
			-- 				-- Ignore all files for analysis to exclusively use Ruff for linting
			-- 				ignore = { "*" },
			-- 			},
			-- 		},
			-- 	},
			-- })

			vim.lsp.config("ruff", {})
			vim.lsp.enable("ruff")
			-- lspconfig.ruff.setup({})
			vim.lsp.config("stylua", {})
			vim.lsp.enable("stylua")
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})
			vim.lsp.enable("lua_ls")
			-- vim.lsp.enable("stylua")
			-- lspconfig.lua_ls.setup({
			-- 	capabilities = capabilities,
			-- })
			vim.lsp.config("html", {
				capabilities = capabilities,
			})
			vim.lsp.enable("html")
			-- lspconfig.html.setup({
			-- 	capabilities = capabilities,
			-- })
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})
			vim.lsp.enable("ts_ls")

			-- lspconfig.ts_ls.setup({
			-- 	capabilities = capabilities,
			-- on_attach = function(client)
			-- 	-- disable ALL diagnostics from tsserver
			-- 	client.handlers["textDocument/publishDiagnostics"] = function() end
			-- end,
			-- })
			vim.lsp.config("cssls", {
				capabilities = capabilities,
			})
			vim.lsp.enable("cssls")
			-- lspconfig.cssls.setup({
			-- 	capabilities = capabilities,
			-- })
			vim.lsp.config("jsonls", {
				capabilities = capabilities,
			})
			vim.lsp.enable("jsonls")
			-- lspconfig.jsonls.setup({
			-- 	capabilities = capabilities,
			-- })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.diagnostic.config({
				virtual_text = true, -- show inline errors (like red squiggles)
				signs = true, -- show icons in the sign column
				underline = true, -- underline issues
				update_in_insert = false, -- update diagnostics while typing
				severity_sort = true, -- sort by severity
			})
		end,
	},
}
