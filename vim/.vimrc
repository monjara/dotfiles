vim9script

syntax enable
colorscheme habamax

filetype plugin on

set hlsearch
set clipboard+=unnamed
set foldcolumn=3
set cmdheight=3
set incsearch
set hlsearch
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
set autoindent
set smartindent
set hidden

inoremap jj <Esc>
nnoremap s <Cmd>call autoload#Stargate(1)<CR>
nnoremap <space>dd <Cmd>e .<CR>

