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
					-- none-ls source config
					command = function(params)
						-- helpers (same as before) ...
						local function is_win()
							return vim.loop.os_uname().version:match("Windows")
						end

						local function file_exists(p)
							local st = vim.loop.fs_stat(p)
							return st and st.type == "file"
						end

						local function has_legacy_config(root)
							return vim.fn.filereadable(root .. "/.eslintrc.json") == 1
								or vim.fn.filereadable(root .. "/.eslintrc.js") == 1
								or vim.fn.filereadable(root .. "/.eslintrc.yml") == 1
								or vim.fn.filereadable(root .. "/.eslintrc.yaml") == 1
						end

						local function local_bin(root, name)
							local suffix = is_win() and ".cmd" or ""
							local p = root .. "/node_modules/.bin/" .. name .. suffix
							return file_exists(p) and p or nil
						end

						local root = params.root or vim.fn.getcwd()
						local legacy = has_legacy_config(root)
						if legacy then
							return local_bin(root, "eslint") or "eslint"
						else
							return local_bin(root, "eslint_d") or "eslint_d"
						end
					end,

					args = function(params)
						local function has_legacy_config(root)
							return vim.fn.filereadable(root .. "/.eslintrc.json") == 1
								or vim.fn.filereadable(root .. "/.eslintrc.js") == 1
								or vim.fn.filereadable(root .. "/.eslintrc.yml") == 1
								or vim.fn.filereadable(root .. "/.eslintrc.yaml") == 1
						end

						local function has_flat_config(root)
							return vim.fn.filereadable(root .. "/eslint.config.js") == 1
								or vim.fn.filereadable(root .. "/eslint.config.mjs") == 1
								or vim.fn.filereadable(root .. "/eslint.config.cjs") == 1
								or vim.fn.filereadable(root .. "/eslint.config.ts") == 1
						end

						local root = params.root or vim.fn.getcwd()
						local legacy = has_legacy_config(root)
						local flat = has_flat_config(root)

						local a = {
							"--format",
							"json", -- force JSON so none-ls can decode
							"--stdin", -- read code from stdin
							"--stdin-filename",
							params.bufname, -- make ESLint resolve config/ignores properly
							"--no-error-on-unmatched-pattern", -- avoid noisy errors on single files
						}

						if legacy then
							-- helps plugin resolution in monorepos for legacy configs
							table.insert(a, "--resolve-plugins-relative-to")
							table.insert(a, root)
						elseif flat then
							-- optional but explicit; ESLint will auto-find it anyway
							-- table.insert(a, "--config"); table.insert(a, root .. "/eslint.config.js")
							-- Flat config sometimes warns a lot about ignores:
							table.insert(a, "--no-warn-ignored")
						else
							table.insert(a, "--no-warn-ignored")
						end

						return a
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
