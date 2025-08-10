return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>n", ":Neotree toggle <CR>", { desc = "Open project tree" })
		vim.keymap.set("n", ",", ":Neotree reveal<CR>", { desc = "Reveal file in Neo-tree" })
		require("neo-tree").setup({
			-- sync_root_with_cwd = true,
			-- respect_buf_cwd = true,
			-- update_focused_file = {
			-- 	enable = true,
			-- 	update_root = true,
			-- },
			filesystem = {
				filtered_items = {
					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
		})
	end,
}
