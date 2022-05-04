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

" if dein#check_install()
"  call dein#install()
" endif
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
"


" coc.nvim https://github.com/neoclide/coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> gk :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fs  <Plug>(coc-format-selected)
nmap <leader>fs  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `Kaap` for current paragraph
xmap <leader>as  <Plug>(coc-codeaction-selected)
nmap <leader>as  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> sla  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> sle  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> slc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> slo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> sls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> sj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> sk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> sp  :<C-u>CocListResume<CR>

