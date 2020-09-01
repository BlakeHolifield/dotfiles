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
 
"" Advanced
set ruler	" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

call plug#begin('~/.vim/plugged')

" Themes

" Language Syntax Support

" Tools
Plug 'mitermayer/vim-prettier'
Plug 'jiangmiao/auto-pairs' "Autocomplete brackets. 
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }


Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} "Nerdtree

" All of your Plugins must be added before the following line
call plug#end()            " required

map <C-n> :NERDTreeToggle<CR>
