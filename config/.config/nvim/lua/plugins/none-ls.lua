return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		local function has_eslint_config(params)
			local start = vim.fs.dirname(params.bufname)
			local config = vim.fs.find({
				"eslint.config.js",
				"eslint.config.cjs",
				"eslint.config.mjs",
				"eslint.config.ts",
				".eslintrc",
				".eslintrc.js",
				".eslintrc.cjs",
				".eslintrc.json",
				".eslintrc.yml",
				".eslintrc.yaml",
			}, {
				upward = true,
				path = start,
				stop = vim.loop.os_homedir(),
			})[1]

			return config ~= nil
		end

		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"html",
						"css",
						"json",
						"yaml",
						"markdown",
						"vue",
						"svelte",
					},
				}),
				require("none-ls.formatting.eslint").with({
					condition = has_eslint_config,
				}),
				require("none-ls.diagnostics.eslint").with({
					condition = has_eslint_config,
				}),
				require("none-ls.code_actions.eslint").with({
					condition = has_eslint_config,
				}),
			},

			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					local group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false })

					vim.api.nvim_clear_autocmds({
						group = group,
						buffer = bufnr,
					})

					vim.api.nvim_create_autocmd("BufWritePre", {
						group = group,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								filter = function(format_client)
									return format_client.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
			})
		end, { desc = "Format file" })
	end,
}
