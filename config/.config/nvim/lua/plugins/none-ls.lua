return {
	"nvimtools/none-ls.nvim", -- use :Mason to /search and (I)nstall e.g.: stylua
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint_d, -- ESLint for diagnostics
				null_ls.builtins.formatting.prettier.with({
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
				--        null_ls.builtins.formatting.rubocop -- remember to add diagnostics for used languages
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
