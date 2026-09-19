return {
  'nvim-mini/mini.files',
  version = '*',

  keys = {
    {
      '<space>df',
      function()
        require('mini.files').open()
      end,
      { desc = 'open project top' },
    },
    {
      '<space>dd',
      function()
        require('mini.files').open(vim.api.nvim_buf_get_name(0), false)
      end,
      { desc = 'open current file' },
    },
  },

  opts = {
    content = {
      filter = nil,
      highlight = nil,
      prefix = nil,
      sort = nil,
    },

    mappings = {
      close = 'q',
      go_in = 'l',
      go_in_plus = 'L',
      go_out = 'h',
      go_out_plus = 'H',
      mark_goto = "'",
      mark_set = 'm',
      reset = '<BS>',
      reveal_cwd = '@',
      show_help = 'g?',
      synchronize = ':w',
      trim_left = '<',
      trim_right = '>',
    },

    options = {
      permanent_delete = true,
      use_as_default_explorer = true,
      lsp_timeout = 1000,
    },

    windows = {
      max_number = 2,
      preview = true,
      width_focus = 100,
      width_nofocus = 15,
      width_preview = 100,
    },
  },

  config = function(_, opts)
    local MiniFiles = require('mini.files')

    --------------------------------------------------------------------------
    -- Git status
    --------------------------------------------------------------------------

    local git_status = {}

    local git_namespace = vim.api.nvim_create_namespace('mini_files_git_status')

    local git_highlights = {
      M = 'MiniDiffSignChange',
      A = 'MiniDiffSignAdd',
      D = 'MiniDiffSignDelete',
      R = 'MiniDiffSignChange',
      ['?'] = 'MiniDiffSignAdd',
    }

    local status_priority = {
      D = 5,
      M = 4,
      R = 3,
      A = 2,
      ['?'] = 1,
    }

    local function stronger_status(current, new)
      if current == nil then
        return new
      end

      if status_priority[new] > status_priority[current] then
        return new
      end

      return current
    end

    local function add_parent_statuses(statuses, path, status, root)
      local parent = vim.fs.dirname(path)

      while parent and parent ~= root and vim.startswith(parent, root .. '/') do
        statuses[parent] = stronger_status(statuses[parent], status)

        parent = vim.fs.dirname(parent)
      end

      if parent == root then
        statuses[root] = stronger_status(statuses[root], status)
      end
    end

    local function parse_git_status(output, root)
      local statuses = {}

      for line in output:gmatch('[^\r\n]+') do
        local xy = line:sub(1, 2)
        local path = line:sub(4)

        -- Rename: "old -> new"
        local renamed_path = path:match('^.+ %-> (.+)$')
        if renamed_path then
          path = renamed_path
        end

        local status

        if xy == '??' then
          status = '?'
        elseif xy:find('D', 1, true) then
          status = 'D'
        elseif xy:find('M', 1, true) then
          status = 'M'
        elseif xy:find('R', 1, true) then
          status = 'R'
        elseif xy:find('A', 1, true) then
          status = 'A'
        end

        if status then
          local full_path = vim.fs.normalize(root .. '/' .. path)

          statuses[full_path] = status
        end
      end

      -- 子要素のstatusを親directoryにも伝播
      local file_statuses = vim.deepcopy(statuses)

      for path, status in pairs(file_statuses) do
        add_parent_statuses(statuses, path, status, root)
      end

      return statuses
    end

    local function update_git_status()
      local cwd = vim.fn.getcwd()

      -- まずGit rootを取得
      vim.system({
        'git',
        '-C',
        cwd,
        'rev-parse',
        '--show-toplevel',
      }, {
        text = true,
      }, function(root_result)
        if root_result.code ~= 0 then
          git_status = {}

          vim.schedule(function()
            MiniFiles.refresh()
          end)

          return
        end

        local root = vim.fs.normalize(vim.trim(root_result.stdout))

        vim.system({
          'git',
          '-C',
          root,
          '-c',
          'core.quotepath=false',
          'status',
          '--porcelain=v1',
          '--untracked-files=all',
        }, {
          text = true,
        }, function(result)
          if result.code ~= 0 then
            git_status = {}
          else
            git_status = parse_git_status(result.stdout, root)
          end

          vim.schedule(function()
            -- BufferUpdateを発火させてextmarkを描き直す
            MiniFiles.refresh()
          end)
        end)
      end)
    end

    --------------------------------------------------------------------------
    -- Prefix
    --
    -- Git用に左3文字を必ず確保。
    -- icon自体はMiniFiles.default_prefix()のhighlightを維持。
    --------------------------------------------------------------------------

    opts.content.prefix = function(entry)
      local icon, icon_hl = MiniFiles.default_prefix(entry)

      return '   ' .. icon, icon_hl
    end

    MiniFiles.setup(opts)

    --------------------------------------------------------------------------
    -- Git extmarks
    --------------------------------------------------------------------------

    local function update_git_extmarks(buf_id)
      if not vim.api.nvim_buf_is_valid(buf_id) then
        return
      end

      vim.api.nvim_buf_clear_namespace(buf_id, git_namespace, 0, -1)

      -- Preview bufferではget_fs_entry()が使えないため除外
      if vim.bo[buf_id].filetype ~= 'minifiles' then
        return
      end

      local line_count = vim.api.nvim_buf_line_count(buf_id)

      for line = 1, line_count do
        local ok, entry = pcall(MiniFiles.get_fs_entry, buf_id, line)

        if ok and entry then
          local path = vim.fs.normalize(entry.path)

          local status = git_status[path]

          if status then
            vim.api.nvim_buf_set_extmark(buf_id, git_namespace, line - 1, 0, {
              virt_text = {
                {
                  status .. '  ',
                  git_highlights[status] or 'Comment',
                },
              },
              virt_text_pos = 'overlay',
              hl_mode = 'combine',
            })
          end
        end
      end
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferUpdate',

      callback = function(args)
        update_git_extmarks(args.data.buf_id)
      end,
    })

    --------------------------------------------------------------------------
    -- Git status refresh
    --------------------------------------------------------------------------

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesExplorerOpen',
      callback = update_git_status,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = {
        'MiniFilesActionCreate',
        'MiniFilesActionDelete',
        'MiniFilesActionRename',
        'MiniFilesActionCopy',
        'MiniFilesActionMove',
      },

      callback = update_git_status,
    })
  end,
}
