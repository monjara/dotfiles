return {
  'nvim-mini/mini.snippets',
  version = '*',
  config = function()
    local MiniSnippets = require('mini.snippets')

    MiniSnippets.setup(
    -- No need to copy this inside `setup()`. Will be used automatically.
    {
      snippets = {
        MiniSnippets.gen_loader.from_lang()
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Expand snippet at cursor position. Created globally in Insert mode.
        expand = '<C-s>',

        -- Interact with default `expand.insert` session.
        -- Created for the duration of active session(s)
        jump_next = '<C-l>',
        jump_prev = '<C-h>',
        stop = '<C-c>',
      },

      -- Functions describing snippet expansion. If `nil`, default values
      -- are `MiniSnippets.default_<field>()`.
      expand = {
        -- Resolve raw config snippets at context
        prepare = nil,
        -- Match resolved snippets at cursor position
        match = nil,
        -- Possibly choose among matched snippets
        select = nil,
        -- Insert selected snippet
        insert = nil,
      },
    })
  end,
}
