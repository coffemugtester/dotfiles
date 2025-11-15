return {
	"nvimtools/none-ls.nvim", -- use :Mason to /search and (I)nstall e.g.: stylua
	event = "VeryLazy",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.mypy,
				-- null_ls.builtins.diagnostics.ruff,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd.with({
					-- env = {
					-- PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json"),
					-- },
					-- Optionally specify filetypes:
					filetypes = {
						"javascript",
						"typescript",
						"html",
						"css",
						"json",
						"yaml",
						"markdown",
						"vue",
						"svelte",
					},
				}),
				-- ESLint setup with root detection at package.json/node_modules
				-- (useful for JS/TS subdirectories in non-JS projects)
				require("none-ls.diagnostics.eslint_d").with({
					cwd = function(params)
						return require("null-ls.utils").root_pattern(
							"package.json",
							"node_modules",
							".eslintrc",
							".eslintrc.js",
							".eslintrc.json",
							"eslint.config.js"
						)(params.bufname)
					end,
				}),
				require("none-ls.code_actions.eslint_d").with({
					cwd = function(params)
						return require("null-ls.utils").root_pattern(
							"package.json",
							"node_modules",
							".eslintrc",
							".eslintrc.js",
							".eslintrc.json",
							"eslint.config.js"
						)(params.bufname)
					end,
				}),
			},
			-- on_attach run this function which is going to format the document.
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
