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
  { "catppuccin/nvim",               as = "catppuccin" },
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
  { "theniceboy/nvim-deus" },
  {
    "shaunsingh/moonlight.nvim",
    config = function()
      vim.g.moonlight_italic_comments = true
      vim.g.moonlight_italic_keywords = true
      vim.g.moonlight_italic_functions = true
      vim.g.moonlight_italic_variables = false
      vim.g.moonlight_contrast = true
      vim.g.moonlight_borders = false
      vim.g.moonlight_disable_background = false
    end,
  },
  {
    "yorik1984/newpaper.nvim",
    config = true,
  },
  {
    "ofirgall/ofirkai.nvim",
    config = function()
      require('ofirkai').setup {}
    end
  },
  {
    "yashguptaz/calvera-dark.nvim",
    config = function()
      vim.g.calvera_italic_keywords = true
      vim.g.calvera_borders = true
      vim.g.calvera_contrast = true
      vim.g.calvera_hide_eob = true
      vim.g.calvera_custom_colors = { contrast = "#0f111a" }
      vim.g.calvera_borders = false
      vim.g.calvera_disable_background = false
      vim.g.transparent_bg = true
    end
  },
  {
    'marko-cerovac/material.nvim',
    config = function()
      require('material').setup({

        contrast = {
          terminal = true,            -- Enable contrast for the built-in terminal
          sidebars = true,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = true,    -- Enable contrast for floating windows
          cursor_line = true,         -- Enable darker background for the cursor line
          non_current_windows = true, -- Enable darker background for non-current windows
          filetypes = {},             -- Specify which filetypes get the contrasted (darker) background
        },

        styles = { -- Give comments style such as bold, italic, underline etc.
          comments = { italic = true --[[ italic = true ]] },
          strings = { --[[ bold = true ]] },
          keywords = { bold = true --[[ underline = true ]] },
          functions = { bold = true, italic = true --[[ bold = true, undercurl = true ]] },
          variables = { italic = true },
          operators = { bold = true },
          types = { italic = true },
        },

        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          "dap",
          -- "dashboard",
          "gitsigns",
          "hop",
          "indent-blankline",
          -- "lspsaga",
          -- "mini",
          "neogit",
          "nvim-cmp",
          "nvim-navic",
          -- "nvim-tree",
          "nvim-web-devicons",
          -- "sneak",
          "telescope",
          "trouble",
          "which-key",
        },

        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false,        -- Disable borders between verticaly split windows
          background = false,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false,    -- Prevent the theme from setting terminal colors
          eob_lines = false       -- Hide the end-of-buffer lines
        },

        high_visibility = {
          lighter = true, -- Enable higher contrast text for lighter style
          darker = true   -- Enable higher contrast text for darker style
        },

        lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

        async_loading = true,      -- Load parts of the theme asyncronously for faster startup (turned on by default)

        custom_colors = nil,       -- If you want to everride the default colors, set this to a function

        custom_highlights = {},    -- Overwrite highlights with your own
      })
    end
  },
  { "sainnhe/sonokai" },
  {
    "NLKNguyen/papercolor-theme",
    config = function()
      vim.cmd([[
        let g:PaperColor_Theme_Options = {
          \   'theme': {
          \     'default': {
          \       'allow_bold': 1,
          \       'allow_italic': 1
          \     }
          \   }
          \ }
      ]])
    end
  }
}
