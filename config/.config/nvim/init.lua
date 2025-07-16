
vim.g.mapleader = " "

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Map shortcuts
vim.keymap.set("n", "<leader>w", ":w<CR>")       -- Save
vim.keymap.set("n", "<leader>q", ":q<CR>")       -- Quit
vim.keymap.set("n", "<leader>x", ":wq<CR>")      -- Save & Quit
vim.keymap.set("n", "<leader>e", ":Ex<CR>")      -- Open netrw

-- Yank to clipboard in visual mode
vim.keymap.set("v", "<C-y>", '"+y', { noremap = true })

-- You already use <C-p> for Telescope, so use <leader>p instead:
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true })

-- Run macro in register a
vim.keymap.set("n", "<leader>a", "@a", { noremap = true })

-- Relative line numbers, but absolute on current line
vim.opt.number = true
vim.opt.relativenumber = true

-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Syntax highlighting
vim.cmd("syntax on")

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable mouse support
-- vim.opt.mouse = "a"

-- Show matching brackets
-- vim.opt.showmatch = true

-- Use system clipboard
-- vim.opt.clipboard = "unnamedplus"

-- Disable line wrapping
-- vim.opt.wrap = false


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
  { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" }
}
local opts = {}

require("lazy").setup(plugins, opts)
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', function()
  builtin.find_files({
    hidden = true,
    no_ignore = true,
    follow = true,
  })
end, {})
vim.keymap.set('n', '<leader>fg', function()
  builtin.live_grep({
    additional_args = function()
      return { "--hidden", "--glob", "!.git/*" }
    end
  })
end, {})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript"},
  highlight = { enable = true},
  indent = { enable = true},
})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
