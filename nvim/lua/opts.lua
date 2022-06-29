vim.opt.number = true
vim.opt.fenc = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.showmatch = true
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.opt.visualbell = true
vim.opt.splitright = true
vim.opt.cmdheight = 2
vim.opt.laststatus = 2
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.virtualedit = 'onemore'
vim.opt.wildmode = 'list:longest'

vim.opt.shortmess:append('c')
vim.opt.clipboard:append('unnamedplus')

vim.opt.autoindent = true -- 改行時に前の行のインデントを計測
vim.opt.smartindent = true -- "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
vim.opt.cindent = true -- "Cプログラムファイルの自動インデントを始める
vim.opt.smarttab = true -- "新しい行を作った時に高度な自動インデントを行う
vim.opt.expandtab = true -- "タブ入力を複数の空白に置き換える

vim.opt.tabstop = 2 -- "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
vim.opt.shiftwidth = 2 -- "自動インデントで入る空白数
vim.opt.softtabstop = 0 -- "キーボードから入るタブの数

if vim.fn.has("autocmd") == 1 then
  vim.cmd([[
autocmd FileType javascript       setlocal sw=2 sts=2 ts=2 et
autocmd FileType typescript       setlocal sw=2 sts=2 ts=2 et
autocmd FileType javascriptreact  setlocal sw=2 sts=2 ts=2 et
autocmd FileType typescriptreact  setlocal sw=2 sts=2 ts=2 et

filetype off
filetype plugin indent on
]] )
end


