return {
  {
    "kwkarlwang/bufresize.nvim",
    config = function()
      local opts = { noremap = true, silent = true }
      require("bufresize").setup({
        register = {
          keys = {
            { "n", "<leader>w<", "30<C-w><",     opts },
            { "n", "<leader>w>", "30<C-w>>",     opts },
            { "n", "<leader>w+", "10<C-w>+",     opts },
            { "n", "<leader>w-", "10<C-w>-",     opts },
            { "n", "<leader>w_", "<C-w>_",       opts },
            { "n", "<leader>w=", "<C-w>=",       opts },
            { "n", "<leader>w|", "<C-w>|",       opts },
            { "n", "<leader>wo", "<C-w>|<C-w>_", opts },
          },
          trigger_events = { "BufWinEnter", "WinEnter" },
        },
        resize = {
          keys = {},
          trigger_events = { "VimResized" },
        },
      })
    end,
  },
  {
    'declancm/maximize.nvim',
    config = function() require('maximize').setup({ default_keymaps = false }) end
  },
  -- {
  --   "anuvyklack/windows.nvim",
  --   dependencies = {
  --     "anuvyklack/middleclass",
  --     "anuvyklack/animation.nvim"
  --   },
  --   config = function()
  --     vim.o.winwidth = 12
  --     vim.o.winminwidth = 1
  --     vim.o.winheight = 20
  --     vim.o.winminheight = 1
  --     vim.o.equalalways = false
  --     require('windows').setup()
  --   end
  -- },
  {
    "danilamihailov/beacon.nvim",
    config = function()
      vim.api.nvim_set_var("beacon_enable", true)
      vim.api.nvim_set_var("beacon_size", 80)
      vim.api.nvim_set_var("beacon_minimal_jump", 2)
      -- vim.api.nvim_set_var("beacon_ignore_buffers", { "\\w*git*\\w" })
      vim.api.nvim_set_var("beacon_ignore_filetypes", { 'trouble', 'telescope', 'terminal', 'fzf' })
      vim.api.nvim_set_hl(0, "Beacon", { bg = my.color.my.vimode[vim.fn.mode()], ctermbg = "magenta" })
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function() require("plugins.config.symbols_outline").setup() end,
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.config.trouble").setup()
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function() require("plugins.config.zen").setup() end,
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.73,    -- amount of dimming
          inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 21,      -- amount of lines we will try to show around the current line
        treesitter = true, -- use treesitter when available for the filetype
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      })
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("plugins.config.scrollbar").setup()
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    dependencies = { "petertriho/nvim-scrollbar" },
    config = function() require("plugins.config.hlslens").setup() end,
  },
}
