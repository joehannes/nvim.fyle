--@diagnostic disable: undefined-global
local M = {
  MyBootAugroup = {
    ["VimEnter"] = {
      pattern = "*",
      callback = my.fn.onAfterBoot,
    }
  },
  MyHighlightAugroup = {
    ["TextYankPost"] = {
      pattern = "*",
      callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", hlgroup = "IncSearch", timeout = 2000 }
      end,
    },
    ["CursorHold"] = {
      pattern = "*",
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    }
    -- ["BufEnter"] = {
    --   {
    --     pattern = "*",
    --     callback = my.fn.activate_current_win_sep,
    --   },
    -- },
    -- ["BufLeave"] = {
    --   {
    --     pattern = "*",
    --     callback = my.fn.clear_current_win_sep,
    --   },
    -- }
  },
  MyColorAugroup = {
    ["ModeChanged"] = {
      pattern = "*",
      callback = my.fn.onModeChanged,
    },
    ["ColorScheme"] = {
      pattern = "*",
      callback = my.fn.onColorscheme,
    }
  },
  MyReadAugroup = {
    ["BufNewFile,BufRead"] = {
      {
        pattern = "*.md,*.org,*.wiki,*.dict,*.txt",
        callback = function()
          vim.cmd("setlocal spell")
        end,
      },
      {
        pattern = "*.org,*.wiki",
        callback = function()
          vim.cmd("setfiletype markdown")
        end,
      }
    }
  },
  MyWriteAugroup = {
    ["BufWritePre"] = {
      pattern = "*.clj,*.cljc,*.cljs",
      callback = function()
        -- vim.cmd("CljFmt")
      end
    },
    ["BufWritePost"] = {
      pattern = "plugins.lua",
      callback = function()
        vim.cmd([[source <afile> | PackerCompile]])
      end
    },
  },
  MyTerminalAugroup = {
    ["TermOpen,TermEnter"] = {
      pattern = "*",
      callback = function()
        vim.cmd([[
          setlocal nonumber norelativenumber foldcolumn=0 nocursorline
          startinsert
        ]])
      end,
    }
  },
  MyListsAugroup = {
    ["BufEnter,BufWinEnter,FocusGained"] = {
      pattern = "qf,trouble,help",
      callback = function()
        vim.cmd([[
          setlocal nonumber norelativenumber foldcolumn=0 nocursorcolumn
        ]])
      end,
    }
  },
  MyCursorAugroup = {
    ["VimEnter,WinEnter,BufWinEnter"] = {
      pattern = "*",
      callback = function()
        vim.cmd("setlocal cursorline cursorcolumn")
      end,
    },
    ["WinLeave"] = {
      pattern = "*",
      callback = function()
        vim.cmd("setlocal nocursorline nocursorcolumn")
      end,
    },
    ["BufEnter,BufWinEnter,InsertLeave,FocusGained"] = {
      pattern = "*",
      callback = function(opts)
        vim.api.nvim_set_option_value("number", true, { buf = opts.buf })
        vim.api.nvim_set_option_value("relativenumber", true, { buf = opts.buf })
        -- vim.cmd("setlocal number relativenumber")
      end,
    },
    ["BufLeave,BufWinLeave,InsertEnter,FocusLost"] = {
      pattern = "*",
      callback = function(opts)
        vim.api.nvim_set_option_value("number", true, { buf = opts.buf })
        vim.api.nvim_set_option_value("relativenumber", false, { buf = opts.buf })
      end,
    }
  },
  MyFoldsAugroup = {
    ["BufWinEnter"] = {
      {
        pattern = "*.lua,*.clj,*.cljs,*.ts,*.tsx,*.js,*.jsx,*.json",
        callback = function()
          vim.cmd("silent! loadview")
        end,
      },
    },
    ["BufWinLeave,BufWritePre"] = {
      {
        pattern = "*.lua,*.clj,*.cljs,*.ts,*.tsx,*.js,*.jsx,*.json",
        callback = function()
          vim.cmd("mkview")
        end,
      },
    }
  }
}

return M
