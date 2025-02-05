vim.go.foldexpr = "nvim_treesitter#foldexpr()"

local M = {}

function M.ts_setup()
  -- local ts_parsers = require "nvim-treesitter.parsers"
  -- local ft_to_parser = ts_parsers.filetype_to_parsername
  -- ft_to_parser["typescriptreact"] = "tsx"

  require("nvim-treesitter.configs").setup({
    ensure_installed = "all", -- maintained is deprecated as of 30/04/2022
    indent = {
      enable = true,
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {},  -- list of language that will be disabled
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>v",
        node_incremental = "s[",
        scope_incremental = "s{",
        node_decremental = "S[",
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
      -- colors = {},
      -- termcolors = {},
    },
    refactor = {
      smart_rename = {
        enable = false,       --true,
        keymaps = {
          smart_rename = nil, --"gR",
        },
      },
    },
    autopairs = { enable = true },
    autotag = { enable = true },
    -- context_commentstring = {
    --   enable = true,
    -- },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_previous_start = {
          ["[af"] = "@function.outer",
          ["[if"] = "@function.inner",
          ["[am"] = "@class.outer",
          ["[im"] = "@class.inner",
          ["[ab"] = "@block.outer",
          ["[ib"] = "@block.inner",
          ["[a?"] = "@conditional.outer",
          ["[i?"] = "@conditional.inner",
          ["[ax"] = "@loop.outer",
          ["[ix"] = "@loop.inner",
        },
        goto_previous_end = {
          ["[Af"] = "@function.outer",
          ["[If"] = "@function.inner",
          ["[Am"] = "@class.outer",
          ["[Im"] = "@class.inner",
          ["[Ab"] = "@block.outer",
          ["[Ib"] = "@block.inner",
          ["[A?"] = "@conditional.outer",
          ["[I?"] = "@conditional.inner",
          ["[Ax"] = "@loop.outer",
          ["[Ix"] = "@loop.inner",
        },
        goto_next_start = {
          ["]af"] = "@function.outer",
          ["]if"] = "@function.inner",
          ["]am"] = "@class.outer",
          ["]im"] = "@class.inner",
          ["]ab"] = "@block.outer",
          ["]ib"] = "@block.inner",
          ["]a?"] = "@conditional.outer",
          ["]i?"] = "@conditional.inner",
          ["]ax"] = "@loop.outer",
          ["]ix"] = "@loop.inner",
        },
        goto_next_end = {
          ["]Af"] = "@function.outer",
          ["]If"] = "@function.inner",
          ["]Am"] = "@class.outer",
          ["]Im"] = "@class.inner",
          ["]Ab"] = "@block.outer",
          ["]Ib"] = "@block.inner",
          ["]A?"] = "@conditional.outer",
          ["]I?"] = "@conditional.inner",
          ["]Ax"] = "@loop.outer",
          ["]Ix"] = "@loop.inner",
        },
      },
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["am"] = "@class.outer",
          ["im"] = "@class.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["a?"] = "@conditional.outer",
          ["i?"] = "@conditional.inner",
          ["ax"] = "@loop.outer",
          ["ix"] = "@loop.inner",
        },
      },
    },
    textsubjects = {
      enable = true,
      prev_selection = ",",
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
      },
    },
  })
end

function M.ts_refactor_setup()
  require("nvim-treesitter.configs").setup({
    rainbow = {
      enable = true,
      extended_mode = false,
    },
    autotag = {
      enable = true,
      highlight = {
        enable = true,
        highlight_delay = 200,
        highlight_method = "block",
        highlight_group = "TSRefactorHighlight",
      },
    },
    refactor = {
      highlight_definitions = {
        enable = true,
        -- Set to false if you have an `updatetime` of ~100.
        clear_on_cursor_move = true,
      },
      highlight_current_scope = { enable = false },
      navigation = {
        enable = true,
        keymaps = {
          goto_previous_usage = "<leader>#",
          goto_next_usage = "<leader>*",
        },
      },
    },
  })
end

function M.ts_vto_setup()
  require("various-textobjs").setup({ useDefaultKeymaps = true })
end

return M
