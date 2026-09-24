return {
  cmd = { 'clojure-lsp' },
  filetypes = { 'clojure', 'clojurescript', 'edn' },
  root_markers = {
    'deps.edn',
    'project.clj',
    'build.boot',
    'shadow-cljs.edn',
    '.git',
  },
}
