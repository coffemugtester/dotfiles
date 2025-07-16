vim.g.mapleader = " "

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.o.autoindent = true
-- vim.o.smartindent = true
-- vim.o.cindent = false  -- optional, depending on language


-- Map shortcuts
vim.keymap.set("n", "<leader>w", ":wa<CR>")       -- Save
vim.keymap.set("n", "<leader>q", ":q<CR>")       -- Quit
vim.keymap.set("n", "<leader>x", ":wq<CR>")      -- Save & Quit
vim.keymap.set("n", "<leader>e", ":Ex<CR>")      -- Open netrw

-- Neotree
-- vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left<CR>") -- Open project tree

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
