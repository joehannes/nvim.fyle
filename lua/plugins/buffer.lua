return {
  {
    "kwkarlwang/bufresize.nvim",
    config = function()
      local opts = { noremap = true, silent = true }
      require("bufresize").setup({
        register = {
          keys = {
            { "n", "<leader>w<", "30<C-w><", opts },
            { "n", "<leader>w>", "30<C-w>>", opts },
            { "n", "<leader>w+", "10<C-w>+", opts },
            { "n", "<leader>w-", "10<C-w>-", opts },
            { "n", "<leader>w_", "<C-w>_", opts },
            { "n", "<leader>w=", "<C-w>=", opts },
            { "n", "<leader>w|", "<C-w>|", opts },
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
          alpha = 0.73, -- amount of dimming
          inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 21, -- amount of lines we will try to show around the current line
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
