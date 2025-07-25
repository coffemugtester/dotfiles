if vim.env.COLORTERM == "truecolor" or vim.env.COLORTERM == "24bit" then
	return {
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	}
else
	return {}
end
