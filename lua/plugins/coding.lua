return {
  {
    "jackMort/ChatGPT.nvim",
    config = require("plugins.config.chat_gpt").setup,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  -- {
  --   'xbase-lab/xbase',
  --   build = 'make install', -- or "make install && make free_space" (not recommended, longer build time)
  -- dependencies = {
  --   "neovim/nvim-lspconfig",
  --   "nvim-telescope/telescope.nvim", -- optional
  --   "nvim-lua/plenary.nvim",         -- optional/requirement of telescope.nvim
  --   "stevearc/dressing.nvim",        -- optional (in case you don't use telescope but something else)
  --},
  --    config = function( ]])
  -- require("config.xbase").setup()
  -- end
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = require("plugins.config.treesitter").ts_setup,
    branch = "master"
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    config = require("plugins.config.treesitter").ts_refactor_setup,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "chrisgrieser/nvim-various-textobjs",
    config = require("plugins.config.treesitter").ts_vto_setup,
  },
  { "RRethy/nvim-treesitter-textsubjects" },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function() require("treesitter-context").setup() end,
  },
  { "mfussenegger/nvim-ts-hint-textobject" },
  { "wellle/targets.vim" },
  {
    "mizlan/iswap.nvim",
    config = function() require("iswap").setup() end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup() end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      require("ts_context_commentstring").setup({})
    end
  },
  { "haringsrob/nvim_context_vt" },
  { "machakann/vim-sandwich" },
  -- { "andymass/vim-matchup" },
  { "windwp/nvim-ts-autotag" },
  { "p00f/nvim-ts-rainbow" },
  {
    "windwp/nvim-autopairs",
    dependencies = { "windwp/nvim-ts-autotag" },
    config = function()
      require("plugins.config.autopairs").setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  { "antoinemadec/FixCursorHold.nvim" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    }
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        library = { plugins = { "neotest" }, types = true },
      })
    end
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },
  -- { "puremourning/vimspector" },
  { "kshenoy/vim-signature" },
  { "sheerun/vim-polyglot" },
  { "othree/es.next.syntax.vim" },
  { "othree/javascript-libraries-syntax.vim" }
}
