return {
	"David-Kunz/gen.nvim",
	config = function()
		require("gen").setup({
			model = "qwen3:14b", -- The default model to use.
			show_model = true,
			think = false, -- Whether to show thinking messages.
			body = { think = false, stream = true },
			command = function(options)
				return "curl --silent --no-buffer -X POST http://"
					.. options.host
					.. ":"
					.. options.port
					.. "/api/chat -d $body"
			end,
		})
		vim.keymap.set({ "n", "v" }, "<leader>o", ":Gen<CR>")
	end,
}
