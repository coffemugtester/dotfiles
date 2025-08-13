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
				-- require("none-ls.diagnostics.eslint_d"),
				require("none-ls.diagnostics.eslint").with({
					name = "eslint_d",
					meta = {
						url = "https://github.com/mantoni/eslint_d.js/",
						description = "Like ESLint, but faster.",
						notes = {
							"Once spawned, the server will continue to run in the background. This is normal and not related to null-ls. You can stop it by running `eslint_d stop` from the command line.",
						},
					},
					command = "eslint_d",
					-- args = {
					-- 	"--no-warn-ignored",
					-- },
					args = function(params)
						local root = params.root or vim.fn.getcwd()
						local has_eslint_config_js = vim.fn.filereadable(root .. "/eslint.config.js") == 1
						-- local has_eslintrc_json = vim.fn.filereadable(root .. "/.eslintrc.json") == 1

						local base_args = {}

						if has_eslint_config_js then
							table.insert(base_args, "--no-warn-ignored")
						end

						table.insert(base_args, params.bufname)

						return base_args
					end,
				}),
				require("none-ls.code_actions.eslint"),
				-- --        null_ls.builtins.formatting.rubocop -- remember to add diagnostics for used languages
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
