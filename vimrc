"" General
set number	" Show line numbers
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
set nospell     " No spell checking
 
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	  " Auto-indent new lines
set shiftwidth=2  " Number of auto-indent spaces
set smartindent	  " Enable smart-indent
set smarttab	  " Enable smart-tabs
set softtabstop=2 " Number of spaces per Tab
set autowrite
 
"" Advanced
set ruler	" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

let mapleader=","

map <C-n> :cp<CR>
map <C-m> :cn<CR>
nnoremap <leader>a :ccl<CR>

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

call plug#begin('~/.vim/plugged')

Plug 'mitermayer/vim-prettier'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs' "Autocomplete brackets. 
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-fugitive'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" All of your Plugins must be added before the following line
call plug#end()            " required

colorscheme nord
