-- https://github.com/oskarrrrrrr/symbols.nvim?tab=readme-ov-file#tips
return {
	"oskarrrrrrr/symbols.nvim",
	config = function()
		local r = require("symbols.recipes")
		require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
			sidebar = {
				-- custom settings here
				-- e.g. hide_cursor = false
			},
		})
		vim.keymap.set("n", "<leader>s", "<cmd>Symbols<CR>")
		vim.keymap.set("n", "<leader>S", "<cmd>SymbolsClose<CR>")
	end,
}
