return {
	"ojroques/nvim-osc52",
	config = function()
		require("osc52").setup({
			max_length = 0,
			silent = false,
			trim = false,
			-- tmux_passthrough = true,
		})

		local function osc_copy(lines, _)
			require("osc52").copy(table.concat(lines, "\n"))
		end
		local function osc_paste()
			return { vim.fn.getreg("+") }, vim.fn.getregtype("+")
		end

		-- Optionally guard so this only runs in Docker or when no system clipboard is available:
		local in_docker = (vim.uv or vim.loop).fs_stat("/.dockerenv") ~= nil
			or os.getenv("IN_DOCKER") == "1"
			or os.getenv("container") ~= nil
		local has_sys_clip = vim.fn.executable("pbcopy") == 1
			or vim.fn.executable("xclip") == 1
			or vim.fn.executable("xsel") == 1
			or vim.fn.executable("wl-copy") == 1

		if in_docker or not has_sys_clip then
			vim.g.clipboard = {
				name = "osc52",
				copy = { ["+"] = osc_copy, ["*"] = osc_copy },
				paste = { ["+"] = osc_paste, ["*"] = osc_paste },
			}
		end

		-- Your visual keymap still handy:
		vim.keymap.set("v", "<C-y>", require("osc52").copy_visual, { noremap = true, silent = true })
	end,
}
