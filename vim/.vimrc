" Map leader key to space
let mapleader = " "

" Map vim shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :wq<CR>
nnoremap <leader>e :Ex<CR>   " open netrw file explorer
" Use <leader>y to yank to clipboard in visual and normal mode
vnoremap <C-y> "+y
nnoremap <C-p> "+p

" Map Ctrl + Space to run macro in register a (normal mode)
nnoremap <leader>a @a

" Show relative line numbers (absolute on current line)
set number
set relativenumber

" Use spaces instead of tabs
set expandtab
set shiftwidth=2
set softtabstop=2

" Enable syntax highlighting
syntax on

" Highlight search matches
set hlsearch
set incsearch
set ignorecase
set smartcase

" Enable mouse support
set mouse=a

" Show matching parentheses/brackets
set showmatch

" Use system clipboard (if supported)
set clipboard=unnamedplus

" Line wrapping (optional)
set nowrap

