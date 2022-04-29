" dein
if &compatible
  set nocompatible " Be iMproved
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($HOME . '/.config/nvim/dein')
  call dein#begin($HOME . '/.cache/dein')
    let s:toml_dir  = $HOME . '/.config/nvim/dein/toml' 
    let s:toml      = s:toml_dir . '/dein.toml'
    let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
    let s:plug_dir  = s:toml_dir . '/plugins'
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#load_toml(s:plug_dir . '/defx.toml',        {'lazy': 0})
    call dein#load_toml(s:plug_dir . '/neoterm.toml',     {'lazy': 0})
    call dein#load_toml(s:plug_dir . '/fzf.toml',         {'lazy': 0})
    call dein#load_toml(s:plug_dir . '/easy-motion.toml', {'lazy': 0})
    call dein#load_toml(s:plug_dir . '/coc.toml',         {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
 call dein#install()
endif
" dein end

" prefix
let mapleader= ","
nnoremap <Space> <Nop>
nnoremap [s] <Nop>
nnoremap s <Nop>
nmap s [s]

" charcter
set fenc=utf-8
set encoding=utf-8

set ignorecase
set wildignorecase

set number
set hidden
set showcmd
set autoread
set nobackup
set showmatch
set noswapfile 
set cursorline
set visualbell
set splitright
set cmdheight=2
set nocompatible
set laststatus=2
set shortmess+=c
set nowritebackup
set updatetime=300
set virtualedit=onemore
set wildmode=list:longest
set clipboard+=unnamedplus

filetype off
filetype plugin indent on

" onedark theme setting
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=256
let g:onedark_terminal_italics=0

if !has('gui_running')
  set t_Co=256
endif

if !empty($TMUX)
  set termguicolors
endif

let g:onedark_color_overrides = {
\ "background": {"gui": "#000000", "cterm": "255", "cterm16": "000" },
\}

syntax on
colorscheme onedark
" onedark theme setting end

" lightline-setting
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \ },
  \ }
function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
" lightline-setting end

if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


" === indent =============================================================
set autoindent          "改行時に前の行のインデントを計測
set smartindent         "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set cindent             "Cプログラムファイルの自動インデントを始める
set smarttab            "新しい行を作った時に高度な自動インデントを行う
set expandtab           "タブ入力を複数の空白に置き換える

set tabstop=2           "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
set shiftwidth=2        "自動インデントで入る空白数
set softtabstop=0       "キーボードから入るタブの数

if has("autocmd")
autocmd FileType javascript       setlocal sw=2 sts=2 ts=2 et
autocmd FileType typescript       setlocal sw=2 sts=2 ts=2 et
autocmd FileType javascriptreact  setlocal sw=2 sts=2 ts=2 et
autocmd FileType typescriptreact  setlocal sw=2 sts=2 ts=2 et
end
" === indent end =======================================================

" ==== custom command ==================================================
" open vim setting file
command! -nargs=0 VV :tabnew $MYVIMRC
" source vim setting file
command! -nargs=0 SV :source ~/.config/nvim/init.vim
" open help vertical split
command! -nargs=1 -complete=help H :vertical belowright help <args>
" ==== custom command end ==============================================

" ==== noremap =========================================================
noremap \  ,
" ==== noremap =========================================================

" ==== nnoremap ========================================================
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <silent> <leader>n :<C-u> nohl <CR>
nnoremap <silent> <leader>o :<C-u> only <CR>

" ==== nnoremap end ===================================================

" ==== inoremap =======================================================
inoremap <silent> jj <ESC>
" ==== inoremap end ===================================================

" ==== tnoremap =======================================================
tnoremap <silent> <A-i> <C-\><C-n> 
" ==== tnoremap end ===================================================
 
" ==== Nop ============================================================
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" ==== Nop end ========================================================
