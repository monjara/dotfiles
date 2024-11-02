vim9script
import autoload 'autoload.vim'

syntax enable
colorscheme habamax

filetype plugin on

set hlsearch

autoload#CreateHighlights()
augroup StargateReapplyHighlights
    autocmd!
    autocmd ColorScheme * autoload#CreateHighlights()
augroup END
autoload#CreateLabelWindows()

inoremap jj <Esc>
nnoremap s <Cmd>call autoload#Stargate(1)<CR>
