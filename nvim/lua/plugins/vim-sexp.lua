local ft = { "clojure", "scheme", "lisp", "racket", "fennel", "edn" }

return {
  "guns/vim-sexp",
  ft = ft,
  dependencies = {
    { "tpope/vim-sexp-mappings-for-regular-people", ft = ft },
    { "tpope/vim-repeat",                           ft = ft },
    'nvim-mini/mini.surround',
  },
}
