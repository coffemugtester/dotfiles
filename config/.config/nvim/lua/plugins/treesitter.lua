return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			--      ensure_installed = {"lua", "javascript"},
			auto_install = true, -- makes it unnecessary to explicitly list every language for highlighting
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
