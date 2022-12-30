vim.opt.shortmess:append('c')
vim.opt.clipboard:append('unnamedplus')

for k, v in pairs({
  number = true,
  fenc = 'utf-8',
  encoding = 'utf-8',
  ignorecase = true,
  wildignorecase = true,
  hidden = true,
  showcmd = true,
  autoread = true,
  backup = false,
  showmatch = true,
  swapfile = false,
  cursorline = true,
  visualbell = true,
  splitright = true,
  cmdheight = 2,
  laststatus = 2,
  writebackup = false,
  updatetime = 300,
  virtualedit = 'onemore',
  wildmode = 'list:longest',
  autoindent = true, -- 改行時に前の行のインデントを計測
  smartindent = true, -- "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
  cindent = true, -- "Cプログラムファイルの自動インデントを始める
  smarttab = true, -- "新しい行を作った時に高度な自動インデントを行う
  expandtab = true, -- "タブ入力を複数の空白に置き換える
  tabstop = 2, -- "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
  shiftwidth = 2, -- "自動インデントで入る空白数
  softtabstop = 0, -- "キーボードから入るタブの数
}) do
  vim.opt[k] = v
end

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  callback = function()
    vim.opt_local.sw = 2
    vim.opt_local.sts = 2
    vim.opt_local.ts = 2
    vim.opt_local.et = true
  end
})

vim.cmd([[
filetype off
filetype plugin indent on
]])

vim.g.python3_host_prog = '/home/ya/.anyenv/envs/pyenv/shims/python'
