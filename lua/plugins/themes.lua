return {
  {
    "themercorp/themer.lua",
    config = function() require("plugins.config.themer").setup() end,
  },
  {
    "ray-x/starry.nvim",
    config = function() require("plugins.config.starry").setup() end,
  },
  { "savq/melange" },
  {
    "joehannes-ux/lush-jsx.nvim",
    config = function()
      vim.g.lush_jsx_contrast_dark = "hard"
      vim.g.lush_jsx_contrast_light = "hard"

      require("lush_jsx").setup({
        plugins = {
          "cmp", -- nvim-cmp
          "gitsigns",
          "lsp",
          "lspsaga",
          "neogit",
          "telescope",
          "treesitter",
        },
        langs = {
          "clojure",
          "css",
          "html",
          "js",
          "json",
          "jsx",
          "lua",
          "markdown",
          "python",
          "typescript",
          "viml",
          "xml",
        },
      })
    end
  },
  { "akai54/2077.nvim" },
  { 'shaeinst/roshnivim-cs' },
  { "olimorris/onedarkpro.nvim" },
  { "pineapplegiant/spaceduck" },
  {
    dir = "https://gitlab.com/__tpb/monokai-pro.nvim",
    as = "monokaipro",
    config = function()
      vim.g.monokaipro_filter = "spectrum"
      vim.g.monokaipro_italic_functions = true
      vim.g.monokaipro_sidebars = { "aerial" }
      vim.g.monokaipro_flat_term = true
    end,
  },
  { 'pappasam/papercolor-theme-slim' },
  { "catppuccin/nvim", as = "catppuccin" },
  { "joehannes-ux/kat.nvim" },
  {
    "meijieru/edge.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },
  { "folke/tokyonight.nvim" },
  { "B4mbus/oxocarbon-lua.nvim" },
  {
    'f-person/auto-dark-mode.nvim',
    config = function()
      local auto_dark_mode = require('auto-dark-mode')

      auto_dark_mode.setup({
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option('background', 'dark')
        end,
        set_light_mode = function()
          vim.api.nvim_set_option('background', 'light')
        end,
      })
      auto_dark_mode.init()
    end
  }
}
