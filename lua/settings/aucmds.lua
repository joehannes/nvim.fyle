--@diagnostic disable: undefined-global

local M = {
  MyBootAugroup = {
    [{ "VimEnter" }] = {
      pattern = "*",
      callback = function()
        my.fn.onAfterBoot()
        vim.schedule(function()
          vim.cmd("SessionLoad")
        end)
      end
    },
  },
  PersistedHooks = {
    [{ "User" }] = {
      {
        pattern = "PersistedLoadPre",
        callback = function()
          -- heirline_setup(false)
        end
      },
      {
        pattern = "PersistedTelescopeLoadPre",
        callback = function()
          -- heirline_setup(false)
        end
      },
      {
        pattern = "PersistedLoadPost",
        callback = function()
          vim.schedule(function()
            -- vim.api.nvim_set_option_value('winbar', "", { scope = "global" })
            -- heirline_setup(true)
          end)
        end
      },
      {
        pattern = "PersistedTelescopeLoadPost",
        callback = function()
          -- heirline_setup(true)
        end
      },
    },
  },
  MyHighlightAugroup = {
    [{ "TextYankPost" }] = {
      pattern = "*",
      callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", hlgroup = "IncSearch", timeout = 2000 }
      end,
    },
    -- {"CursorHold"} = {
    --   pattern = "*",
    --   callback = function()
    --     local opts = {
    --       focusable = false,
    --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --       border = 'rounded',
    --       source = 'always',
    --       prefix = ' ',
    --       scope = 'cursor',
    --     }
    --     vim.diagnostic.open_float(nil, opts)
    --   end,
    -- }
    -- {"BufEnter"} = {
    --   {
    --     pattern = "*",
    --     callback = my.fn.activate_current_win_sep,
    --   },
    -- },
    -- {"BufLeave"} = {
    --   {
    --     pattern = "*",
    --     callback = my.fn.clear_current_win_sep,
    --   },
    -- }
  },
  MyColorAugroup = {
    [{ "ModeChanged" }] = {
      pattern = "*",
      callback = my.fn.onModeChanged,
    },
    [{ "ColorScheme" }] = {
      pattern = "*",
      callback = my.fn.onColorscheme,
    }
  },
  MyReadAugroup = {
    [{ "BufNewFile", "BufRead" }] = {
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
    [{ "BufWritePre" }] = {
      pattern = "*.clj,*.cljc,*.cljs",
      callback = function()
        -- vim.cmd("CljFmt")
      end
    },
    [{ "BufWritePost" }] = {
      pattern = "plugins.lua",
      callback = function()
        vim.cmd([[source <afile> | PackerCompile]])
      end
    },
  },
  MyTerminalAugroup = {
    [{ "TermOpen", "TermEnter" }] = {
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
    [{ "BufEnter", "BufWinEnter", "FocusGained" }] = {
      pattern = "qf,trouble,help",
      callback = function()
        vim.cmd([[
          setlocal nonumber norelativenumber foldcolumn=0 nocursorcolumn
        ]])
      end,
    }
  },
  MyCursorAugroup = {
    [{ "WinEnter", "BufWinEnter" }] = {
      pattern = "*",
      callback = function()
        vim.cmd("setlocal cursorline cursorcolumn")
      end,
    },
    [{ "WinLeave" }] = {
      pattern = "*",
      callback = function()
        vim.cmd("setlocal nocursorline nocursorcolumn")
      end,
    },
    [{ "BufEnter", "BufWinEnter", "InsertLeave", "FocusGained" }] = {
      pattern = "*.*",
      callback = function(opts)
        vim.api.nvim_set_option_value("relativenumber", true, { scope = "local" })
      end,
    },
    [{ "BufLeave", "BufWinLeave", "InsertEnter", "FocusLost" }] = {
      pattern = "*.*",
      callback = function(opts)
        vim.api.nvim_set_option_value("relativenumber", false, { scope = "local" })
      end,
    }
  },
  MyFoldsAugroup = {
    [{ "BufWinEnter" }] = {
      {
        pattern = "*.lua,*.clj,*.cljs,*.ts,*.tsx,*.js,*.jsx,*.json",
        callback = function()
          vim.cmd("silent! edit")
          vim.cmd("silent! loadview")
        end,
      },
    },
    [{ "BufWinLeave", "BufWritePre" }] = {
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
