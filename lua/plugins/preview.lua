return {
  {
    "dnlhc/glance.nvim",
    config = function()
      local glance = require('glance')
      local actions = glance.actions

      glance.setup({
        height = 18, -- Height of the window
        zindex = 45,
        preview_win_opts = { -- Configure preview window options
          cursorline = true,
          number = true,
          wrap = true,
        },
        border = {
          enable = true, -- Show window borders. Only horizontal borders allowed
          top_char = '=',
          bottom_char = '=',
        },
        list = {
          position = 'right', -- Position of the list window 'left'|'right'
          width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
          enable = true, -- Will generate colors for the plugin based on your current colorscheme
          mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
          list = {
            ['j'] = actions.next, -- Bring the cursor to the next item in the list
            ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
            ['<Down>'] = actions.next,
            ['<Up>'] = actions.previous,
            ['<Tab>'] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ['<C-u>'] = actions.preview_scroll_win(5),
            ['<C-d>'] = actions.preview_scroll_win(-5),
            ['v'] = actions.jump_vsplit,
            ['s'] = actions.jump_split,
            ['t'] = actions.jump_tab,
            ['o'] = actions.jump,
            ['<leader>l'] = actions.enter_win('preview'), -- Focus preview window
            ['<CR>'] = actions.enter_win('preview'), -- Focus preview window
            ['q'] = actions.close,
            ['Q'] = actions.close,
            ['<Esc>'] = actions.close,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ['Q'] = actions.close,
            ['<Tab>'] = actions.next_location,
            ['<S-Tab>'] = actions.previous_location,
            ['<leader>l'] = actions.enter_win('list'), -- Focus list window
          },
        },
        hooks = {},
        folds = {
          fold_closed = '',
          fold_open = '',
          folded = true, -- Automatically fold list on startup
        },
        indent_lines = {
          enable = true,
          icon = '│',
        },
        winbar = {
          enable = false, -- Available strating from nvim-0.8+
        },
      })
    end,
  },
  {
    'lewis6991/hover.nvim',
    config = function()
      require('hover').setup {
        init = function()
          require('hover.providers.lsp')
          -- require('hover.providers.gh')
          require('hover.providers.man')
          require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = "rounded",
          winbar = nil,
        },
        title = true,
        winbar = nil
      }

      -- Setup keymaps
      -- vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
      -- vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
    end
  },
  {
    'JASONews/glow-hover',
    config = function()
      require 'glow-hover'.setup {
        max_width = 70,
        padding = 2,
        border = 'shadow',
        glow_path = 'glow'
      }
    end
  },
  {
    'mrjones2014/dash.nvim',
    build = 'make install',
    config = function()
      require("dash").setup({
        -- configure path to Dash.app if installed somewhere other than /Applications/Dash.app
        dash_app_path = '/Applications/Dash.app',
        -- search engine to fall back to when Dash has no results, must be one of: 'ddg', 'duckduckgo', 'startpage', 'google'
        search_engine = 'google',
        -- debounce while typing, in milliseconds
        debounce = 100,
        -- map filetype strings to the keywords you've configured for docsets in Dash
        -- setting to false will disable filtering by filetype for that filetype
        -- filetypes not included in this table will not filter the query by filetype
        -- check src/lua_bindings/dash_config_binding.rs to see all defaults
        -- the values you pass for file_type_keywords are merged with the defaults
        -- to disable filtering for all filetypes,
        -- set file_type_keywords = false
        file_type_keywords = {
          dashboard = false,
          NvimTree = false,
          TelescopePrompt = false,
          terminal = false,
          packer = false,
          fzf = false,
          -- a table of strings will search on multiple keywords
          lua = { "lua", "Neovim" },
          clojure = { 'clojure', 'clj', 'javascript', 'html', 'svg', 'css' },
          javascript = { 'javascript', 'html', 'svg', 'nodejs', 'css', 'sass', 'react' },
          typescript = { 'typescript', 'javascript', 'nodejs', 'html', 'svg', 'nodejs', 'css', 'sass' },
          typescriptreact = { 'typescript', 'javascript', 'html', 'svg', 'nodejs', 'css', 'sass', 'react' },
          javascriptreact = { 'javascript', 'html', 'svg', 'nodejs', 'css', 'sass', 'react' },
          -- you can also do a string, for example,
          -- sh = 'bash'
        },
      })
    end
  }
}
