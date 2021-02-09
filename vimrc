"" General
set number	" Show line numbers
set relativenumber
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
set noerrorbells
set nospell     " No spell checking
 
set hlsearch	" Highlight all search results
set incsearch	" Searches for strings incrementally
set scrolloff=8  " Scroll when 8 from bottom
 
set autoindent	  " Auto-indent new lines
set shiftwidth=2  " Number of auto-indent spaces
set smartindent	  " Enable smart-indent
set smarttab	  " Enable smart-tabs
set softtabstop=2 " Number of spaces per Tab
set autowrite
set termguicolors " tmux so pretty now

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" powerline
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
 
"" Advanced
set ruler	" Show row and column ruler information
set signcolumn=yes " Debugger column on left
set colorcolumn=80  " warning line at 80 chars
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

let mapleader=","

" quickfix menu bindings
nnoremap <leader>n :cp<CR>
nnoremap <leader>m :cn<CR>
nnoremap <leader>a :ccl<CR>

" vim-go mapping
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" vim-test 
tmap <silent> <leader>n :TestNearest<CR>
nmap <silent> <leader>f :TestFile<CR>
nmap <silent> <leader>s :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>v :TestVisit<CR>

let test#python#runner = 'pytest'

" airline
let g:airline_powerline_fonts = 1

call plug#begin('~/.vim/plugged')

Plug 'greyblake/vim-preview'
Plug 'mbbill/undotree'
Plug 'luchermitte/vim-refactor'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'vim-test/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround',
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-fugitive'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ruanyl/vim-gh-line'

Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'artanikin/vim-synthwave84'

" All of your Plugins must be added before the following line
call plug#end()            " required


colorscheme synthwave84
