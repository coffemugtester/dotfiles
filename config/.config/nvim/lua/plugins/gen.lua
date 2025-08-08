return {
	"David-Kunz/gen.nvim",
	config = function()
		require("gen").setup({
			model = "gpt-oss:20b", -- The default model to use.
		})
		vim.keymap.set({ "n", "v" }, "<leader>o", ":Gen<CR>")
	end,
}
