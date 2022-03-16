" vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kassio/neoterm'

Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'simeji/winresizer'

Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()
" vim-plug end

" prefix
let mapleader= ","
nnoremap <Space> <Nop>
nnoremap [s] <Nop>
nnoremap s <Nop>
nmap s [s]

" charcter
set fenc=utf-8                 " ファイルの文字エンコード
set encoding=utf-8             " vimの文字エンコード

set ignorecase
set wildignorecase

set number                     " 行番号
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
let &runtimepath.='~/.config/nvim/plugged/neoterm'
filetype plugin indent on

" onedark theme setting
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
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

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" coc.nvim end


" defx.nvim
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
" Define mappings
nnoremap <silent><buffer><expr> <CR>
\ defx#do_action('open')
nnoremap <silent><buffer><expr> c
\ defx#do_action('copy')
nnoremap <silent><buffer><expr> m
\ defx#do_action('move')
nnoremap <silent><buffer><expr> p
\ defx#do_action('paste')
nnoremap <silent><buffer><expr> l
\ defx#do_action('open')
nnoremap <silent><buffer><expr> E
\ defx#do_action('open', 'vsplit')
nnoremap <silent><buffer><expr> T
\ defx#do_action('open', 'tabnew')
nnoremap <silent><buffer><expr> P
\ defx#do_action('preview')
nnoremap <silent><buffer><expr> o
\ defx#do_action('open_tree', 'toggle')
nnoremap <silent><buffer><expr> K
\ defx#do_action('new_directory')
nnoremap <silent><buffer><expr> N
\ defx#do_action('new_file')
nnoremap <silent><buffer><expr> M
\ defx#do_action('new_multiple_files')
nnoremap <silent><buffer><expr> C
\ defx#do_action('toggle_columns',
\                'mark:indent:icon:filename:type:size:time')
nnoremap <silent><buffer><expr> S
\ defx#do_action('toggle_sort', 'time')
nnoremap <silent><buffer><expr> d
\ defx#do_action('remove')
nnoremap <silent><buffer><expr> r
\ defx#do_action('rename')
nnoremap <silent><buffer><expr> !
\ defx#do_action('execute_command')
nnoremap <silent><buffer><expr> x
\ defx#do_action('execute_system')
nnoremap <silent><buffer><expr> yy
\ defx#do_action('yank_path')
nnoremap <silent><buffer><expr> .
\ defx#do_action('toggle_ignored_files') 
nnoremap <silent><buffer><expr> ; 
\ defx#do_action('repeat')
nnoremap <silent><buffer><expr> h
\ defx#do_action('cd', ['..'])
nnoremap <silent><buffer><expr> ~
\ defx#do_action('cd')
nnoremap <silent><buffer><expr> q
\ defx#do_action('quit')
nnoremap <silent><buffer><expr> <Space>
\ defx#do_action('toggle_select') . 'j'
nnoremap <silent><buffer><expr> *
\ defx#do_action('toggle_select_all')
nnoremap <silent><buffer><expr> j
\ line('.') == line('$') ? 'gg' : 'j'
nnoremap <silent><buffer><expr> k
\ line('.') == 1 ? 'G' : 'k'
nnoremap <silent><buffer><expr> <C-l>
\ defx#do_action('redraw')
nnoremap <silent><buffer><expr> <C-g>
\ defx#do_action('print')
nnoremap <silent><buffer><expr> cd
\ defx#do_action('change_vim_cwd')
endfunction

function! s:open_defx_if_directory()
  " This throws an error if the buffer name contains unusual characters like
  " [[buffergator]]. Desired behavior in those scenarios is to consider the
  " buffer not to be a directory.
  try
    let l:full_path = expand(expand('%:p'))
  catch
    return
  endtry

  " If the path is a directory, delete the (useless) buffer and open defx for
  " that directory instead.
  if isdirectory(l:full_path)
    execute "Defx `expand('%:p')` | bd " . expand('%:r')
  endif
endfunction

augroup defx_config
  autocmd!
  autocmd FileType defx call s:defx_my_settings()

  " It seems like BufReadPost should work for this, but for some reason, I can't
  " get it to fire. BufEnter seems to be more reliable.
  autocmd BufEnter * call s:open_defx_if_directory()
  autocmd BufWritePost * call defx#redraw()
  autocmd BufEnter * call defx#redraw()
augroup END

" defx.nvim end

" easymotion setting
let g:EasyMotion_do_mapping=0
nnoremap [easyM] <Nop>
nmap <Space>s [easyM]
nmap [easyM]s <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap [easyM]f <Plug>(easymotion-overwin-f2)
" Move to line
nmap [easyM]l <Plug>(easymotion-overwin-line)
" Move to word
nmap [easyM]w <Plug>(easymotion-overwin-w)
"  end

"vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
"vim-multiple-cursors end

" FZF
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
nnoremap [fzf] <Nop>
nmap <Space>f [fzf]
xmap <Space>f [fzf]
nnoremap <silent> [fzf]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf]r    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf]r    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf]l     :<C-u>CocCommand fzf-preview.LocationList<CR>
" FZF end

" ==== neoterm setting =================================================
let g:neoterm_default_mod      = 'botright'
let g:neoterm_keep_term_open   = 1
let g:neoterm_autoinsert       = 0
let g:neoterm_autojump         = 1

nnoremap [term] <Nop>
nmap <Space>t [term]
nnoremap <silent> [term]t :<C-u>silent call <SID>open_neoterm('Ttoggle')<CR>
nnoremap <silent> [term]n :<C-u>silent call <SID>open_neoterm('Tnew')<CR>
nnoremap <silent> [term]r :<C-u> Tredo <CR>
nnoremap <silent> [term]c :<C-u> Tclear <CR>
nnoremap <silent> [term]d :<C-u> Tclose <CR>

function! s:open_neoterm(cmd) abort
    let split = s:split_type()

    call execute(printf('%s %s', split, a:cmd))
endfunction

function! s:split_type() abort
    let width = winwidth(win_getid())
    let height = winheight(win_getid()) * 2.1

    if height > width
        let g:neoterm_size             = 10
        return 'bel'
    else
        let g:neoterm_size             = 50
        return 'vert'
    endif
endfunction

" ==== neoterm setting end =============================================
"

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
nnoremap <silent> <Space><Space>n :<C-u> nohl <CR>
nnoremap <silent> <Space><Space>o :<C-u> only <CR>
nnoremap <silent> <Space><Space>d :<C-u> Defx <CR>
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

