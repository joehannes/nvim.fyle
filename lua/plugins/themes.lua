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
  },
  {
    "cpea2506/one_monokai.nvim",
    config = function()
      require("one_monokai").setup({
        transparent = true,
        colors = {
          green = my.color.my.green,
          blue = my.color.my.aqua,
          roman = my.color.my.magenta,
          lmao = my.color.util.darken(my.color.util.desaturate(my.color.my.purple, 50),
            vim.opt.background:get() == "light" and 0 or 90),
          pink = my.color.util.desaturate(my.color.my.magenta, 50)
        },
        themes = function(colors)
          return {
            Normal = { bg = colors.lmao },
            Comment = { fg = colors.pink, italic = true },
            ErrorMsg = { fg = "black", bg = my.color.my.red, standout = true },
            NormalFloat = { link = my.color.my.lmao },
          }
        end,
      })
    end
  },
  { "YorickPeterse/vim-paper" }
}
