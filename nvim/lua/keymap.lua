vim.g.mapleader = ','
vim.api.nvim_set_keymap('n', '<space>', '', { noremap = true })
vim.api.nvim_set_keymap('v', '<space>', '', { noremap = true })
vim.api.nvim_set_keymap('n', [[\]], ',', {})
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>n', ':<C-u>nohl<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>o', ':<C-u>only<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'ZZ', '', { noremap = true })
vim.api.nvim_set_keymap('n', 'ZQ', '', { noremap = true })

vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<A-i>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set(
  'n',
  '<space>yf',
  function()
    vim.api.nvim_command('let @" = expand("%:p")')
    vim.api.nvim_command('let @+ = expand("%:p")')
  end
)

vim.keymap.set(
  'n',
  '<space>yd',
  function()
    vim.api.nvim_command('let @" = expand("%:p:h")')
    vim.api.nvim_command('let @+ = expand("%:p:h")')
  end
)

vim.api.nvim_create_autocmd({ 'TabEnter' }, {
  command = 'tcd %:h'
})

-- TODO: implement with nvim_create_user_command()
vim.cmd([[
command! -nargs=0 VV :tabnew $MYVIMRC | :tcd %:h
command! -nargs=0 SV :source ~/.config/nvim/init.lua
command! -nargs=1 -complete=help H :vertical belowright help <args>
]])

vim.cmd([[
function! CreateCenteredFloatingWindow() abort
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    let l:textbuf = nvim_create_buf(v:false, v:true)
    call nvim_open_win(l:textbuf, v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
    return l:textbuf
endfunction

function! FloatingWindowHelp(query) abort
    let l:buf = CreateCenteredFloatingWindow()
    call nvim_set_current_buf(l:buf)
    setlocal filetype=help
    setlocal buftype=help
    execute 'help ' . a:query
endfunction

command! -complete=help -nargs=? Help call FloatingWindowHelp(<q-args>)
]])
